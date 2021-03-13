from typing import Optional

from pydantic import BaseModel, Field, HttpUrl

from utils.pyobjectid import ObjectId, PyObjectId


class Organization(BaseModel):
    """
    쓰샘 기기의 포인트 데이터 모델
    """

    id: Optional[PyObjectId] = Field(alias="_id")
    name: str = Field(description="기관명")
    point: int = Field(default=0, description="기관의 누적 포인트")
    homepage: Optional[HttpUrl] = Field(description="기관 홈페이지")
    phone: Optional[str] = Field(description="기관 전화번호")

    class Config:
        json_encoders = {ObjectId: str}
        schema_extra = {
            "example": {
                "name": "국민대학교",
                "point": 0,
                "homepage": "http://kookmin.ac.kr/",
                "phone": "02-910-4114",
            }
        }
