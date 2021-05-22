from typing import Optional

from pydantic import BaseModel, Field

from utils.pyobjectid import ObjectId, PyObjectId


class User(BaseModel):
    """User Base 모델"""

    id: PyObjectId = Field(alias="_id")
    uid: str = Field(description="사용자의 Firebase 식별자")
    user_name: str = Field(description="사용자의 닉네임")


class UserIn(User):
    """User DB 모델"""

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "_id": "60901b909232236ad8c4f0d6",
                "uid": "60901b909232236ad8c4f0d6",
                "user_name": "우주최강개발자 박정섭",
            }
        }


class UserOut(User):
    """User Response 모델"""

    point: Optional[int] = Field(description="유저의 누적 포인트")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "_id": "60901b909232236ad8c4f0d6",
                "uid": "60901b909232236ad8c4f0d6",
                "user_name": "우주최강개발자 박정섭",
                "point": 0,
            }
        }


class UserTicket(BaseModel):
    """User Ticket 모델"""

    user_name: str = Field(description="유저 닉네임")
    ticket: int = Field(description="유저의 누적 추첨권")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "user_name": "우주최강개발자 박정섭",
                "ticket": 2,
            }
        }
