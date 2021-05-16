from fastapi import APIRouter, HTTPException

from database import db
from models.user import User, UserIn, UserOut

router = APIRouter()


@router.get(
    "/{uid}",
    response_model=UserOut,
    description="모바일 기기 ID 기반 사용자 포인트 정보 반환",
)
async def user_detail(uid: str):
    user = db.users.find_one({"_id": uid})
    if user:
        return user
    else:
        raise HTTPException(status_code=404, detail="User not found")
    