"""Publish 관련된 메소드"""
from typing import Optional

from models.data import CapacityData, PointData
from utils.datetime import get_current_datetime_str
from utils.logger import logger

from mqtt_setting import *


def get_point_data_dict() -> str:
    """Point data 문서 생성"""
    logger.info(mqtt.device_id)
    logger.info(mqtt.organization_id)
    point_data = PointData.validate(
        {
            "device": mqtt.device_id,
            "organization": mqtt.organization_id,
            "date": get_current_datetime_str(),
        }
    )
    point_data = point_data.json(exclude={"id", "point"})
    return point_data


def get_capacity_data_dict(sensor_type: str, sensor_value: float) -> str:
    """Capacity data 문서 생성"""
    state = "ON" if sensor_value >= 100 else "OFF"
    capacity_data = CapacityData.validate(
        {
            "device": mqtt.device_id,
            "organization": mqtt.organization_id,
            "sensor": sensor_type,
            "percentage": sensor_value,
            "state": state,
            "date": get_current_datetime_str(),
        }
    )
    capacity_data = capacity_data.json(exclude={"id"})
    return capacity_data


async def send_point_data(qos: int = 0) -> None:
    """Send point_data"""
    topic = mqtt.topic_point
    data = get_point_data_dict()
    logger.info(f"Publish {topic}, {data}")
    await mqtt.app.publish(topic, data, qos)
    return data


async def send_capacity_data(
    sensor_type: str, sensor_value: float, qos: int = 0
) -> None:
    """Send capacity_data"""
    data = get_capacity_data_dict(sensor_type, sensor_value)
    if sensor_type.lower() == "plastic":
        topic = mqtt.topic_plastic_capacity

        logger.info(f"Publish {topic}, {data}")
        await mqtt.app.publish(topic, data, qos)
    elif sensor_type.lower() == "water":
        topic = mqtt.topic_water_capacity

        logger.info(f"Publish {topic}, {data}")
        await mqtt.app.publish(topic, data, qos)
    return data
