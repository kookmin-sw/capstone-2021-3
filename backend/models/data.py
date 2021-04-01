from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field

from utils.datetime import get_current_datetime_str
from utils.pyobjectid import ObjectId, PyObjectId


class PointData(BaseModel):
    """쓰샘 기기의 포인트 데이터 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    device_name: Optional[str] = Field(description="데이터의 디바이스 id")
    organization_name: Optional[str] = Field(description="데이터를 쌓은 organization 이름")
    user: Optional[str] = Field(description="포인트를 쌓은 유저의 username")
    point: Optional[int] = Field(description="포인트")
    date: datetime = Field(description="데이터 날짜")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "device_name": "kookmin1",
                "organization_name": "kookmin",
                "user": "TaejungHeo",
                "date": get_current_datetime_str(),
            }
        }


class CapacityData(BaseModel):
    """쓰샘 기기의 적재량 데이터 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    device_name: Optional[str] = Field(description="데이터의 디바이스 id")
    organization_name: Optional[str] = Field(description="데이터를 쌓은 organization 이름")
    sensor: str = Field(description="센서 타입 plastic/water")
    percentage: float = Field(description="적재량")
    state: str = Field(description="알림 상태 ON/OFF")
    date: datetime = Field(description="데이터 날짜")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "device_name": "kookmin1",
                "organization_name": "kookmin",
                "sensor": "plastic",
                "percentage": 10.3,
                "state": "ON",
                "date": get_current_datetime_str(),
            }
        }
