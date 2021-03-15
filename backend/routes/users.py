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


@router.post(
    "/",
    response_model=UserOut,
    description="사용자 생성",
)
async def user_create(user: UserIn):
    pass


@router.put(
    "/",
    response_model=UserOut,
    description="사용자 정보 업데이트",
)
async def user_update(user: UserIn):
    pass
