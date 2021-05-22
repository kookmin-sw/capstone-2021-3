from typing import Optional

from pydantic import BaseModel, Field

from utils.datetime import DateTime, get_current_datetime_str
from utils.pyobjectid import ObjectId, PyObjectId


class Device(BaseModel):
    """쓰샘 기기의 포인트 데이터 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    name: str
    model: str
    organization: PyObjectId
    install_date: DateTime

    latitude: float
    longitude: float
    location_description: Optional[str]

    point: Optional[int] = Field(default=0)

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "_id": "60901b909232236ad8c4f0d6",
                "name": "국민쓰샘1호",
                "model": "model_1",
                "organization": "11111b909232236ad8c4f0d6",
                "install_date": get_current_datetime_str(),
                "latitude": 37.61090337619938,
                "longitude": 126.99727816928652,
                "location_description": "국민대학교 미래관 4층 자율주행스튜디오 앞",
                "point": 377,
            }
        }
