from datetime import datetime

from fastapi import APIRouter, HTTPException

from database import db
from models.user import User, UserIn, UserOut, UserTicket

router = APIRouter()


@router.get(
    "/{uid}",
    response_model=UserOut,
    description="사용자 식별자 기반 사용자 포인트 정보 반환",
)
async def user_detail(uid: str):
    user = db.users.find_one({"_id": uid})
    if user:
        return user
    else:
        raise HTTPException(status_code=404, detail="User not found")


@router.get(
    "/{uid}/tickets",
    response_model=UserTicket,
    description="사용자 식별자 기반 현재달의 추첨권 보유량 반환",
)
async def user_tickets(uid: str):
    user = db.users.find_one({"_id": uid})
    result = dict()
    result['user_name'] = user['user_name']

    if user:
        thismonth = int(datetime.today().strftime("%Y%m"))
        num_tickets = len(list(db.tickets.find({"user": uid, "yearmonth": thismonth})))
        result['ticket'] = num_tickets

        return result
    else:
        raise HTTPException(status_code=404, detail="User not found")

