"""MQTT Broker와 MongoDB를 연결하는 Application"""
import json
import logging
from json.decoder import JSONDecodeError

import paho.mqtt.client as mqtt_client
import pika

from config import config
from database import db
from models.data import CapacityData, PointData
from models.organization import Organization
from utils.logger import logger
from utils.pyobjectid import PyObjectId


class OnMessageLog:
    """MQTT 메시지 로그 출력용"""

    def __init__(self, log_level, msg, topic, body) -> None:
        self.log_level: int = log_level
        self.msg: str = msg
        self.topic: str = topic
        self.body: str = body

    def __str__(self) -> str:
        return json.dumps(
            {
                "msg": self.msg,
                "topic": self.topic,
                "body": self.body,
            },
            ensure_ascii=False,
            indent=2,
        )

    def report(self):
        logger.log(self.log_level, str(self))


class MQTTClient:
    def __init__(self, settings) -> None:
        self.settings = settings
        self._client = None

    def connect(self):
        logger.info("Connect to MQTT Broker")
        self._client = mqtt_client.Client(
            clean_session=True,
            protocol=mqtt_client.MQTTv311,
        )

        self._client.username_pw_set(
            username=self.settings.username,
            password=self.settings.password,
        )
        self._client.connect(
            host=self.settings.host,
            port=self.settings.port,
        )

        def on_message(client, userdata, message):
            logger.info(f"Topic 메시지 수신: {client}, {userdata}, {message}")

        self._client.on_message = on_message

    def publish(self, topic, payload, qos=0, retain=False):
        logger.info(f"Topic 발헹: {topic}, {payload}")
        return self._client.publish(topic, payload, qos, retain)


class AMQPConsumer:
    def __init__(self, config, mqtt) -> None:
        self.config = config
        self.mqtt = mqtt

        # 클래스 변수 초기화
        self._conn = None
        self._channel = None

    def run(self):
        while True:
            try:
                self._conn.ioloop.start()
            except KeyboardInterrupt:
                logger.info(f"Rabbitmq 연결 종료")
                self._conn.close()
                self._conn.ioloop.start()
            except Exception as e:
                logger.error(f"Rabbitmq 재연결 시도")
                self._conn.close()
                self._conn.ioloop.start()
                self.connect()

    def connect(self):
        self._conn = pika.SelectConnection(
            self._get_config(),
            on_open_callback=self.on_connected,
        )

    def on_connected(self, connection):
        """RabbitMQ와 연결된 후 실행"""
        logger.info(f"Connect to RabbitMQ")
        connection.channel(on_open_callback=self.on_channel_open)

    def on_channel_open(self, new_channel):
        """Channel이 open 된 후 실행"""
        self._channel = new_channel
        self._channel.queue_declare(
            self.config.queue,  # 큐 이름
            durable=True,  # 메시지가 중간에 소실되지 않도록 보장
            exclusive=False,  # 현재 연결 이외에도 수용
            auto_delete=False,  # 사용하지 않아도 큐가 삭제되지 않음
            callback=self.on_queue_declared,
        )

    def on_queue_declared(self, frame):
        """Queue declared 된 후 실행"""
        self._channel.queue_bind(
            self.config.queue,
            self.config.exchange,
            self.topic_to_routing_key(self.topic_capacity),
        )
        self._channel.queue_bind(
            self.config.queue,
            self.config.exchange,
            self.topic_to_routing_key(self.topic_point),
        )
        self._channel.basic_consume(
            self.config.queue,
            self.on_message,
            auto_ack=False,
        )

    def on_message(self, channel, method, properties, body):
        """데이터를 수신했을 때 실행"""
        topic = method.routing_key
        body = body.decode("utf-8")
        OnMessageLog(logging.INFO, "데이터 수신", topic, body).report()

        level = logging.INFO
        message = "OK"
        try:
            # Topic에서 정보를 추출
            topic_list = topic.split(".")
            organization = PyObjectId(topic_list[-2])
            device = PyObjectId(topic_list[-1])

            # Topic에서 추출한 정보와 시간 정보를 json에 업데이트
            json_data = json.loads(body)
            json_data["organization"] = organization
            json_data["device"] = device
            user = json_data.get("user")
            if user:
                user = PyObjectId(user)
                json_data["user"] = user

            if topic_list[1] in self.topic_capacity:
                # 데이터 validation
                CapacityData.validate(json_data)

                # Capacity data 삽입
                db.capacities.insert_one(json_data)

            elif topic_list[1] in self.topic_point:
                # 데이터 validation
                PointData.validate(json_data)

                # Point data 삽입
                db.points.insert_one(json_data)

                # Organization의 Point + 1
                db.organizations.update_one(
                    {"_id": organization},
                    {"$inc": {"point": 1}},
                    upsert=True,  # 찾는 document가 없을 시 생성
                )

                # Device의 point + 1
                db.devices.update_one(
                    {"_id": device},
                    {"$inc": {"point": 1}},
                    upsert=True,  # 찾는 document가 없을 시 생성
                )

                # User의 Point + 1
                if user:
                    db.users.update_one(
                        {"_id": user},
                        {"$inc": {"point": 1}},
                        upsert=True,  # 찾는 document가 없을 시 생성
                    )

                # 포인트 갱신 요청을 해당하는 기관에 속한 기기에 전달
                self.publish_point_received(organization)

            # Queue에 ACK 신호 송신
            self._channel.basic_ack(delivery_tag=method.delivery_tag)
            OnMessageLog(level, message, topic, body).report()
            return

        except JSONDecodeError as e:
            message = f"올바르지 않은 포맷", {e}
        except IndexError as e:
            message = f"인덱스 에러, {e}"
        except Exception as e:
            message = f"알 수 없는 에러, {e}"

        level = logging.ERROR
        OnMessageLog(level, message, topic, body).report()

        # Error 발생시 NACK 신호 송신
        # requeue=False로 원래 queue로 보내지 다시 메시지를 보내지 않는다.
        self._channel.basic_nack(delivery_tag=method.delivery_tag, requeue=False)

    def _get_config(self) -> pika.ConnectionParameters:
        credentials = pika.PlainCredentials(
            username=self.config.username,
            password=self.config.password,
        )
        config = pika.ConnectionParameters(
            host=self.config.host,
            port=self.config.port,
            virtual_host="/",
            credentials=credentials,
        )
        return config

    def topic_to_routing_key(self, topic: str) -> str:
        """Topic을 routing key로 변환"""
        return topic.replace("/", ".")

    @property
    def topic_capacity(self) -> str:
        """모든 기관의 PLASTIC, WATER 용량 topic"""
        return "device/capacity/#"

    @property
    def topic_point(self) -> str:
        """모든 기관의 POINT topic"""
        return "device/point/#"

    @property
    def topic_point_received(self) -> str:
        """포인트 갱신 요청 topic"""
        return "device/point_received/#"

    def publish_point_received(self, organization_id: PyObjectId):
        topic = self.topic_point_received
        topic = topic.replace("#", str(organization_id))
        organization = db.organizations.find_one({"_id": organization_id})
        organization = Organization.validate(organization)
        organization_json = organization.json(by_alias=True)
        self.mqtt.publish(topic, organization_json, qos=0, retain=True)
        OnMessageLog(logging.INFO, "포인트 수신 신호 전달", topic, organization_json).report()


if __name__ == "__main__":
    # Mqtt client 초기화
    mqtt = MQTTClient(config.mqtt_settings)
    mqtt.connect()

    # consumer 실행
    consumer = AMQPConsumer(config.amqp_settings, mqtt)
    consumer.connect()
    consumer.run()
