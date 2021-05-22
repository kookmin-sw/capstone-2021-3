from datetime import datetime

from fastapi import APIRouter, HTTPException

from database import db
from models.user import User, UserIn, UserOut, UserTicket
from utils.firebasedb import get_user

router = APIRouter()


@router.get(
    "/{uid}",
    response_model=UserOut,
    description="사용자 식별자 기반 사용자 포인트 정보 반환",
)
async def user_detail(uid: str):
    result, user = get_user(uid)
    if result != "success":
        raise HTTPException(status_code=404, detail=result)
    else:
        return user


@router.get(
    "/{uid}/tickets",
    response_model=UserTicket,
    description="사용자 식별자 기반 현재달의 추첨권 보유량 반환",
)
async def user_tickets(uid: str):
    result, user = get_user(uid)
    if result != "success":
        raise HTTPException(status_code=404, detail=result)

    thismonth = int(datetime.today().strftime("%Y%m"))
    num_tickets = len(list(db.tickets.find({"user": uid, "yearmonth": thismonth})))
    
    return UserTicket(user_name=user.user_name, ticket=num_tickets)


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
