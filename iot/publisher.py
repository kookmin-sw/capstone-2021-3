"""Publish 관련된 메소드"""
from datetime import datetime
from random import randint, random
from typing import Optional

from faker import Faker  # TODO: Faker 제거

from base import *

# 사용할 토픽들 정의
TOPIC_PLASTIC_CAPACITY = f"device/capacity/plastic/{organization_name}/{device_name}"
TOPIC_WATER_CAPACITY = f"device/capacity/water/{organization_name}/{device_name}"
TOPIC_POINT = f"device/point/{organization_name}/{device_name}"


def get_point_data_dict(user: Optional[str] = None) -> str:
    """Point data 문서 생성"""
    point_data = PointData.validate(
        {
            "device_name": device_name,
            "organization_name": organization_name,
            "user": user,
            "date": get_current_datetime_str(),
        }
    )
    point_data = point_data.json(exclude={"id", "point"})
    return point_data


def get_capacity_data_dict(sensor_type: str, sensor_value: float) -> str:
    """Capacity data 문서 생성"""
    state = "ON" if sensor_value > 100 else "OFF"
    capacity_data = CapacityData.validate(
        {
            "device_name": device_name,
            "organization_name": organization_name,
            "sensor": sensor_type,
            "percentage": sensor_value,
            "state": state,
            "date": get_current_datetime_str(),
        }
    )
    capacity_data = capacity_data.json(exclude={"id"})
    return capacity_data


async def send_point_data(user: str) -> None:
    """Send point_data"""
    data = get_point_data_dict(user)
    logger.info(f"Publish {TOPIC_POINT}, {data}")
    await mqtt.publish(TOPIC_POINT, data)
    return data


async def send_capacity_data(sensor_type: str, sensor_value: float) -> None:
    """Send capacity_data"""
    data = get_capacity_data_dict(sensor_type, sensor_value)
    if sensor_type.lower() == "plastic":
        logger.info(f"Publish {TOPIC_PLASTIC_CAPACITY}, {data}")
        await mqtt.publish(
            TOPIC_PLASTIC_CAPACITY,
            data,
        )
    elif sensor_type.lower() == "water":
        logger.info(f"Publish {TOPIC_WATER_CAPACITY}, {data}")
        await mqtt.publish(
            TOPIC_WATER_CAPACITY,
            data,
        )
    return data
