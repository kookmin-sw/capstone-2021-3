from typing import Optional

from pydantic import BaseModel, Field

from utils.datetime import DateTime, get_current_datetime_str
from utils.pyobjectid import ObjectId, PyObjectId


class PointData(BaseModel):
    """쓰샘 기기의 포인트 데이터 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    device: PyObjectId = Field(description="데이터의 디바이스 id")
    user: Optional[str] = Field(description="포인트를 쌓은 유저 id")
    date: DateTime = Field(description="쓰샘 투입 날짜")
    reward_date: Optional[DateTime] = Field(description="데이터 날짜")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "_id": "60901b909232236ad8c4f0d6",
                "device": "12341b909232236a2314f0d6",
                "user": "56781b909232236a2314f0d6",
                "date": get_current_datetime_str(),
                "reward_date": get_current_datetime_str(),
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


class TicketData(BaseModel):
    """사용자 추첨권 데이터 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    organization: PyObjectId = Field(description="추첨권을 발행한 기관 id")
    user: Optional[str] = Field(description="추첨권을 받은 유저 id")
    date: DateTime = Field(description="데이터 날짜")
    yearmonth: int = Field(default=0, description="추첨권의 해당년월 (데이터형태:  YYYYMM)")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "_id": "55551b909232236ad8c4f011",
                "organization": "60901b909232236a2314f0d6",
                "user": "56781b909232236a2314f0d6",
                "date": get_current_datetime_str(),
                "yearmonth": 202101,
            }
        }
