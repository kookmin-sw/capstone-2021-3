from typing import List

from fastapi import APIRouter

from database import db
from models.device import Device
from utils.distance import get_distance_between_two_lat_lon

router = APIRouter()


@router.get(
    "/",
    response_model=List[Device],
    description="모든 쓰샘 기기의 리스트 조회",
)
async def deivce_list():
    return [Device(**i) for i in db.devices.find()]

@router.get(
    "/nearby",
    response_model=List[Device],
    description="사용자 근처 쓰샘 리스트 반환",
)
async def device_nearby_list(latitude: float, longitude: float):
    return sorted(
        [Device(**i) for i in db.devices.find()],
        key=lambda p: get_distance_between_two_lat_lon(
            latitude, longitude, p.latitude, p.longitude
        ),
    )
