import json

from fastapi_mqtt import FastMQTT, MQTTConfig
from gmqtt.mqtt.constants import MQTTv311
import requests
from models.organization import Organization
from utils.logger import logger

from config import config
from iot_utils.database import DBType, db
from websocket_manager import websocket_manager


class Mqtt:
    def __init__(self, settings) -> None:
        self.settings = settings

        self.organization = self.get_organization_info()
        self.device = self.get_device_info()

        self._mqtt = None
        if self.initialized:
            self.fetch_organization_info()
            self.organization = self.get_organization_info()

            self._mqtt: FastMQTT = self.get_mqtt_app()
            self.add_handlers(self._mqtt)
        else:
            logger.error("Initialization is required.")

    @property
    def app(self):
        return self._mqtt

    @property
    def initialized(self):
        return self.organization and self.device

    async def re_initialize(self):
        if self.app:
            await self.app.client.disconnect()

        self.organization = self.get_organization_info()
        self.device = self.get_device_info()

        self._mqtt = self.get_mqtt_app()
        self.add_handlers(self._mqtt)
        await self._mqtt.connection()

    def get_mqtt_config(self):
        return MQTTConfig(
            username=self.settings.username,
            password=self.settings.password,
            host=self.settings.host,
            port=self.settings.port,
            version=MQTTv311,
        )

    def get_mqtt_app(self):
        return FastMQTT(config=self.get_mqtt_config())

    def get_organization_info(self):
        return db.find_one(DBType.organization)

    def get_device_info(self):
        return db.find_one(DBType.device)

    def fetch_organization_info(self):
        response = requests.get(
            f"{config.api_settings.base_url}/organizations/{self.organization_id}"
        )
        response = response.json()
        try:
            organization = Organization.parse_obj(response)
            organization = organization.dict(by_alias=True)
            organization["_id"] = str(organization["_id"])
            if organization:
                db.upsert(DBType.organization, organization)
            logger.info("Success to fetch organization info")
        except Exception as e:
            logger.error(f"Failed to fetch organization info {e}")

    @property
    def device_id(self):
        return self.device.get("_id")

    @property
    def organization_id(self):
        return self.organization.get("_id")

    @property
    def topic_point_group(self):
        return f"device/point_received/{self.organization_id}"

    @property
    def topic_plastic_capacity(self):
        return f"device/capacity/plastic/{self.organization_id}/{self.device_id}"

    @property
    def topic_water_capacity(self):
        return f"device/capacity/water/{self.organization_id}/{self.device_id}"

    @property
    def topic_point(self):
        return f"device/point/{self.organization_id}/{self.device_id}"

    def add_handlers(self, app):
        @app.on_connect()
        def connect(client, flags, rc, properties):
            """MQTT Broker에 연결이 되었을 때 동작하는 Handler"""
            logger.info(f"Connected: {client}, {flags}, {rc}, {properties}")

            # qos 1로 최소 1번은 변경을 수신할 수 있도록 한다.
            app.client.subscribe(
                self.topic_point_group,
                qos=0,
            )

        @app.on_disconnect()
        def disconnect(client, packet, exc=None):
            """MQTT Broker와 연결이 끊어졌을 때 동작하는 Handler"""
            logger.info(f"Disconnected client '{client._client_id}'")

        @app.subscribe(self.topic_point_group)
        async def handle_data_topics(client, topic, payload, qos, properties):
            """TOPIC_POINT_GROUP Handler"""
            logger.info(f"point received! {topic}, {payload}")
            response = payload.decode()
            response = json.loads(response)

            # 현재 기기에서 보낸 데이터면 유저의 바코드 입력을 처리
            device_id = response.get("device_id")
            if device_id == self.device_id:
                point_id = response.get("point_id")
                db.upsert(DBType.last_point, point_id)
                await websocket_manager.broadcast("inserted")
            else:
                await websocket_manager.broadcast("point")

            organization = Organization.parse_obj(response.get("organization"))
            organization = organization.dict(by_alias=True)
            organization["_id"] = str(organization["_id"])
            db.upsert(DBType.organization, organization)


mqtt = Mqtt(config.mqtt_settings)
