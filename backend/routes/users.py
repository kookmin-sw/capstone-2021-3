from fastapi import APIRouter

from models.user import User, UserIn, UserOut

router = APIRouter()


@router.get(
    "/{device_id}",
    response_model=UserOut,
    description="모바일 기기 ID 기반 사용자 포인트 정보 반환",
)
async def user_detail():
    pass
