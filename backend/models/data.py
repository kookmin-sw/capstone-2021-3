from typing import Optional

from pydantic import BaseModel, Field

from utils.datetime import DateTime, get_current_datetime_str
from utils.pyobjectid import ObjectId, PyObjectId


class PointData(BaseModel):
    """쓰샘 기기의 포인트 데이터 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    organization: PyObjectId = Field(description="데이터의 디바이스 id")
    user: Optional[PyObjectId] = Field(description="포인트를 쌓은 유저 id")
    point: int = Field(default=0, description="포인트")
    date: DateTime = Field(description="데이터 날짜")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "_id": "60901b909232236ad8c4f0d6",
                "organization": "60901b909232236a2314f0d6",
                "user": "userid",
                "point": 40,
                "date": get_current_datetime_str(),
            }
        }


class CapacityData(BaseModel):
    """쓰샘 기기의 적재량 데이터 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    device: Optional[PyObjectId] = Field(description="데이터의 디바이스 id")
    organization: Optional[PyObjectId] = Field(description="데이터를 쌓은 organization 이름")
    sensor: str = Field(description="센서 타입 plastic/water")
    percentage: float = Field(description="적재량")
    state: str = Field(description="알림 상태 ON/OFF")
    date: DateTime = Field(description="데이터 날짜")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "_id": "60901b909232236ad8c4f0d6",
                "device": "60901b909232236a2341f0d6",
                "sensor": "plastic",
                "percentage": 10.3,
                "state": "ON",
                "date": get_current_datetime_str(),
            }
        }
