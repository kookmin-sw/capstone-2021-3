from pydantic import BaseModel, Field


class Team(BaseModel):
    """
    팀 모델 (사용자의 닉네임)
    """

    name: str = Field(description="팀 이름")
    point: int = Field(description="팀의 누적 포인트")

    class Config:
        schema_extra = {
            "example": {
                "name": "소융대18",
                "point": 30,
            }
        }
