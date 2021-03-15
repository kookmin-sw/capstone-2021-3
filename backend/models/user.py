from typing import Optional

from pydantic import BaseModel, Field

from utils.pyobjectid import ObjectId, PyObjectId


class User(BaseModel):
    """User Base 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    device_id: str = Field(description="기기별 사용자 식별 id")
    team: str = Field(description="사용자가 속한 팀 (닉네임)")


class UserIn(User):
    """User DB 모델"""

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "id": "1",
                "device_id": "9C287922-EE26-4501-94B5-DDE6F83E1475",
                "team": "소융대18",
            }
        }


class UserOut(User):
    """User Response 모델"""

    point: int = Field(description="유저의 누적 포인트")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "id": "1",
                "device_id": "9C287922-EE26-4501-94B5-DDE6F83E1475",
                "team": "소융대18",
                "point": 0,
            }
        }
