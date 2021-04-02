import logging
from os import path
import sys

from fastapi_mqtt import FastMQTT, MQTTConfig
from gmqtt.mqtt.constants import MQTTv311

parent = path.dirname(path.dirname(path.abspath(__file__)))
sys.path.append(path.join(parent, "backend"))

from config import device_settings, mqtt_settings, api_settings
from models.data import CapacityData, PointData
from models.organization import Organization
from utils.datetime import get_current_datetime_str, get_datetime_obj_from_str


# Logger
try:
    from uvicorn.config import logger as uvicorn_logger

    logger = uvicorn_logger
except:
    import logging

    logger = logging.getLogger()

organization_name = device_settings.organization_name
device_name = device_settings.device_name

# Create MQTT Client
mqtt_config = MQTTConfig(
    username=mqtt_settings.username,
    password=mqtt_settings.password,
    host=mqtt_settings.host,
    port=mqtt_settings.port,
    version=MQTTv311,
)
mqtt = FastMQTT(config=mqtt_config)

logger.debug(device_settings.dict())
logger.debug(mqtt_settings.dict())
logger.debug(api_settings.dict())
