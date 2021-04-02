import json

import requests
from fastapi import FastAPI, HTTPException

from base import *
from publisher import *

# 사용할 토픽 정의
TOPIC_POINT_GROUP = f"device/point/{organization_name}/+"

# API base url
BASE_URL = api_settings.base_url

app = FastAPI()

organization: dict = Organization(name=organization_name).dict()


def get_organization_data() -> dict:
    """Organization 정보 요청"""
    res = requests.get(f"{BASE_URL}/organizations/{organization_name}")
    print(f"{BASE_URL}/organizations/{organization_name}")
    print(res)
    try:
        data = json.loads(res.text)
        if res.status_code == 200:
            return Organization.validate(data)
        return data
    except json.decoder.JSONDecodeError as e:
        logger.error(f"{res.text}, {e}")
        return {"error": f"{res.text}, {e}"}


@app.on_event("startup")
async def startup():
    global organization
    organization = get_organization_data()
    await mqtt.connection()


@app.on_event("shutdown")
async def shutdown():
    await mqtt.client.disconnect()


@app.get("/")
def home():
    """디바이스가 속한 Organization의 캐싱된 정보"""
    return organization


@app.post(
    "/point",
    description="포인트 적립",
)
async def point(user: str):
    data = await send_point_data(user)
    return HTTPException(201, data)


@app.post(
    "/capacity",
    description="적재량 업데이트, ['water', 'plastic']",
)
async def capacity(sensor_type: str, sensor_value: float):
    if sensor_type not in ["water", "plastic"]:
        return HTTPException(400, f"{sensor_type} is not in ['water', 'plastic']")
    data = await send_capacity_data(sensor_type, sensor_value)
    return HTTPException(201, data)


@mqtt.on_connect()
def connect(client, flags, rc, properties):
    """MQTT Broker에 연결이 되었을 때 동작하는 Handler"""
    logger.debug(f"Connected: {client}, {flags}, {rc}, {properties}")
    mqtt.client.subscribe(TOPIC_POINT_GROUP)


@mqtt.on_disconnect()
def disconnect(client, packet, exc=None):
    """MQTT Broker와 연결이 끊어졌을 때 동작하는 Handler"""
    logger.debug(f"Disconnected client '{client._client_id}'")


@mqtt.on_subscribe()
def subscribe(client, mid, qos, properties):
    """특정 Topic을 구독했을 때 동작하는 Handler"""
    logger.debug(f"Subscribed client '{client._client_id}', {mid}, {qos}, {properties}")


@mqtt.subscribe(TOPIC_POINT_GROUP)
async def handle_data_topics(client, topic, payload, qos, properties):
    """TOPIC_POINT_GROUP Handler"""

    # TOPIC_POINT_GROUP의 메시지가 발행됐을 때 포인트 갱신 요청
    global organization
    organization = get_organization_data()
