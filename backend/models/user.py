from typing import Optional

from pydantic import BaseModel, Field

from utils.pyobjectid import ObjectId, PyObjectId


class User(BaseModel):
    """User Base 모델"""

    id: Optional[PyObjectId] = Field(alias="_id")
    nickname: str = Field(description="사용자의 닉네임")


class UserIn(User):
    """User DB 모델"""

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "id": "1",
                "nickname": "우주최강개발자 박정섭",
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
                "nickname": "우주최강개발자 박정섭",
                "point": 0,
            }
        }
