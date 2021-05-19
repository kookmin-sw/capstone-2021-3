import datetime
from fastapi import APIRouter

from database import db
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


@router.get(
    "/{uid}/history",
    description="유저가 월별 포인트 실적 조회(최근 6개월)",
)
async def user_history(uid: str):
    points = list(db.points.find({"user": uid}))

    result = dict()
    result['user'] = uid
    result['history'] = dict()

    imonth = datetime.date.today()
    for i in range(6):
        imonth = imonth.replace(day=1)
        yyyymm = imonth.strftime("%Y%m")
        d = imonth.strftime("%Y-%m")
        count = 0

        for i in points:
            if i["date"][:7] == d:
                count += 1

        result['history'][yyyymm] = count
        imonth -= datetime.timedelta(days=1)

    return result