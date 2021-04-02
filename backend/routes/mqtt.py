"""MQTT 프로토콜 구독 및 발행

Topic 구조
- IOT 문서 참고
"""
import json
import os
from json.decoder import JSONDecodeError

from fastapi import APIRouter
from fastapi_mqtt import FastMQTT, MQTTConfig
from gmqtt.mqtt.constants import MQTTv311

from database import db
from models.data import CapacityData, PointData
from utils.datetime import get_datetime_obj_from_str
from utils.logger import logger

TOPIC_CAPACITY = "device/capacity/#"  # 모든 기관의 PLASTIC, WATER 용량
TOPIC_POINT = "device/point/#"  # 모든 기관의 POINT 기록

router = APIRouter()

mqtt_config = MQTTConfig(
    username=os.getenv("MQTT_USERNAME"),
    password=os.getenv("MQTT_PASS"),
    host=os.getenv("MQTT_HOST"),
    port=os.getenv("MQTT_PORT"),
    version=MQTTv311,  # Rabbitmq-mqtt plugin에서 사용하는 MQTT Version이 3.1
)

mqtt = FastMQTT(config=mqtt_config)


@mqtt.on_connect()
def connect(client, flags, rc, properties):
    """MQTT Broker에 연결이 되었을 때 동작하는 Handler

    TOPIC_CAPACITY : 모든 기관의 PLASTIC, WATER 용량
    TOPIC_POINT    : 모든 기관의 POINT 기록
    """
    logger.debug(f"Connected: {client}, {flags}, {rc}, {properties}")

    # 적재량 Topic 구독
    mqtt.client.subscribe(TOPIC_CAPACITY)
    # 포인트 Topic 구독
    mqtt.client.subscribe(TOPIC_POINT)


@mqtt.on_disconnect()
def disconnect(client, packet, exc=None):
    """MQTT Broker와 연결이 끊어졌을 때 동작하는 Handler"""
    logger.debug(f"Disconnected client '{client._client_id}'")


@mqtt.on_subscribe()
def subscribe(client, mid, qos, properties):
    """특정 Topic을 구독했을 때 동작하는 Handler"""
    logger.debug(f"Subscribed client '{client._client_id}', {mid}, {qos}, {properties}")


@mqtt.subscribe(TOPIC_CAPACITY, TOPIC_POINT)
async def handle_data_topics(client, topic, payload, qos, properties):
    """TOPIC_CAPACITY, TOPIC_POINT Handler"""
    try:
        payload = payload.decode()
        logger.debug(f"Topic: {topic}, Msg: {payload}, From: {client._client_id}")

        # Topic에서 정보를 추출
        topic_list = topic.split("/")
        organization_name = topic_list[-2]
        device_name = topic_list[-1]

        # Topic에서 추출한 정보와 시간 정보를 json에 업데이트
        json_data = json.loads(payload)
        json_data["date"] = get_datetime_obj_from_str(json_data["date"])
        json_data["organization_name"] = organization_name
        json_data["device_name"] = device_name

        if topic_list[1] in TOPIC_CAPACITY:
            # 데이터 validation
            CapacityData.validate(json_data)
            # Capacity data 삽입
            db.capacities.insert_one(json_data)
        elif topic_list[1] in TOPIC_POINT:
            # 데이터 validation
            PointData.validate(json_data)
            # Point data 삽입
            db.points.insert_one(json_data)
            # Organization의 Point + 1
            db.organizations.update(
                {"name": organization_name},
                {"$inc": {"point": 1}},
                upsert=True,  # 찾는 document가 없을 시 생성
            )
            # User의 Point + 1
            user = json_data.get("user")
            if user:
                db.users.update(
                    {"name": user},
                    {"$inc": {"point": 1}},
                    upsert=True,  # 찾는 document가 없을 시 생성
                )
    except JSONDecodeError as e:
        logger.error(f"{topic}, {payload}, {e}")
    except IndexError as e:
        logger.error(f"{topic}, {payload}, {e}")
    except Exception as e:
        logger.error(f"{topic}, {payload}, {e}")
