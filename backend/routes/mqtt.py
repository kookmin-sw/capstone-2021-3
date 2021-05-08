"""MQTT 프로토콜 구독 및 발행

Topic 구조
- IOT 문서 참고
"""
import json
from json.decoder import JSONDecodeError

from fastapi import APIRouter
from fastapi_mqtt import FastMQTT, MQTTConfig
from gmqtt.mqtt.constants import MQTTv311

from config import mqtt_settings
from database import db
from models.data import CapacityData, PointData
from utils.datetime import parse_datetime_str
from utils.logger import logger

TOPIC_CAPACITY = "device/capacity/#"  # 모든 기관의 PLASTIC, WATER 용량
TOPIC_POINT = "device/point/#"  # 모든 기관의 POINT 기록

router = APIRouter()

mqtt_config = MQTTConfig(
    username=mqtt_settings.username,
    password=mqtt_settings.password,
    host=mqtt_settings.host,
    port=mqtt_settings.port,
    version=MQTTv311,  # Rabbitmq-mqtt plugin에서 사용하는 MQTT Version이 3.1
)

mqtt = FastMQTT(config=mqtt_config)


@mqtt.on_connect()
def connect(client, flags, rc, properties):
    """MQTT Broker에 연결이 되었을 때 동작하는 Handler

    TOPIC_CAPACITY : 모든 기관의 PLASTIC, WATER 용량
    TOPIC_POINT    : 모든 기관의 POINT 기록
    """
    logger.info(f"MQTT Broker에 연결되었습니다.")

    # 적재량 Topic 구독
    mqtt.client.subscribe(TOPIC_CAPACITY)
    # 포인트 Topic 구독
    mqtt.client.subscribe(TOPIC_POINT)


@mqtt.on_disconnect()
def disconnect(client, packet, exc=None):
    """MQTT Broker와 연결이 끊어졌을 때 동작하는 Handler"""
    logger.info(f"MQTT Broker와 연결이 끊어졌습니다.")


@mqtt.on_subscribe()
def subscribe(client, mid, qos, properties):
    """특정 Topic을 구독했을 때 동작하는 Handler"""
    logger.info(f"토픽을 구독합니다.: 'client_id: {client._client_id}'")


@mqtt.subscribe(TOPIC_CAPACITY, TOPIC_POINT)
async def handle_data_topics(client, topic, payload, qos, properties):
    """TOPIC_CAPACITY, TOPIC_POINT Handler"""
    try:
        payload = payload.decode()
        logger.info(f"데이터 수신, 토픽: {topic}, Msg: {payload}, From: {client._client_id}")

        # Topic에서 정보를 추출
        topic_list = topic.split("/")
        organization_name = topic_list[-2]
        device_name = topic_list[-1]

        # Topic에서 추출한 정보와 시간 정보를 json에 업데이트
        json_data = json.loads(payload)
        json_data["organization_name"] = organization_name
        json_data["device_name"] = device_name

        if topic_list[1] in TOPIC_CAPACITY:
            # 데이터 validation
            CapacityData.validate(json_data)
            # Capacity data 삽입
            result = db.capacities.insert_one(json_data)
        elif topic_list[1] in TOPIC_POINT:
            # 데이터 validation
            PointData.validate(json_data)
            # Point data 삽입
            result = db.points.insert_one(json_data)

            # Organization의 Point + 1
            result = db.organizations.update_one(
                {"name": organization_name},
                {"$inc": {"point": 1}},
                upsert=True,  # 찾는 document가 없을 시 생성
            )

            # User의 Point + 1
            user = json_data.get("user")
            if user:
                result = db.users.update_one(
                    {"name": user},
                    {"$inc": {"point": 1}},
                    upsert=True,  # 찾는 document가 없을 시 생성
                )
    except JSONDecodeError as e:
        logger.error(f"올바르지 않은 포맷, 토픽: {topic}, Msg: {payload}, Error: {e}")
    except IndexError as e:
        logger.error(f"인덱스 에러, 토픽: {topic}, Msg: {payload}, Error: {e}")
    except Exception as e:
        logger.error(f"알 수 없는 에러, 토픽: {topic}, Msg: {payload}, Error: {e}")
    else:
        logger.info(f"정상 처리, 토픽: {topic}, Msg: {payload}")
