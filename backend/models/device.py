from datetime import datetime
from typing import Optional

from pydantic import BaseModel, Field

from models.organization import Organization
from utils.pyobjectid import ObjectId, PyObjectId


class Device(BaseModel):
    """
    쓰샘 기기의 포인트 데이터 모델
    """

    id: Optional[PyObjectId] = Field(alias="_id")
    name: str
    model: str
    organization: Organization
    install_date: datetime

    latitude: float
    longitude: float
    location_description: Optional[str]

    point: int = Field(default=0)

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "name": "국민쓰샘1호",
                "model": "model_1",
                "install_date": "",
                "latitude": "37.61090337619938",
                "longitude": "126.99727816928652",
                "location_description": "국민대학교 미래관 4층 자율주행스튜디오 앞",
                "organization": "국민대학교",
                "point": 377,
            }
        }
