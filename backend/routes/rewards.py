from datetime import datetime

from bson import ObjectId
from fastapi import APIRouter, HTTPException

from database import db
from models.data import PointData, TicketData
from models.device import Device
from models.organization import Organization
from models.user import User, UserOut
from utils.datetime import get_current_datetime_str
from utils.firebasedb import get_user

router = APIRouter()


@router.post(
    "/person_reward",
    response_model=UserOut,
    description="쓰샘기기에서 코드를 통해 포인트 적립",
)
async def person_reward(device_id: str, uid: str, data_id: str):
    # 포인트 데이터 조회
    data = db.points.find_one({"_id": ObjectId(data_id)})
    # data_id 검사
    if not data:
        print("Access denied: data_id is invaild!")
        raise HTTPException(status_code=400, detail="Access denied")
    data = PointData.parse_obj(data)
    # device_id 검사
    if data.device != ObjectId(device_id):
        print("Access denied: device_id is not matched!")
        raise HTTPException(status_code=400, detail="Access denied")
    # 중복 요청 검사
    if data.user:
        print("Access denied: Already rewarded!")
        raise HTTPException(status_code=400, detail="Access denied")
    data.user = uid
    data.reward_date = get_current_datetime_str()

    # 기기ID로 기관 조회
    device = db.devices.find_one({"_id": ObjectId(device_id)})
    organization = db.organizations.find_one({"_id": device["organization"]})

    # 당월 티켓발행수 조회
    thismonth = int(datetime.today().strftime("%Y%m"))
    num_tickets = len(list(db.tickets.find({"user": uid, "yearmonth": thismonth})))

    result, m_user = get_user(uid)
    if result != "success":
        raise HTTPException(status_code=400, detail=result)

    if num_tickets < 3:
        # 추첨권 발행
        new_ticket = TicketData(
            organization=ObjectId(organization["_id"]),
            user=uid,
            date=get_current_datetime_str(),
            yearmonth=thismonth,
        )

        db.tickets.insert_one(new_ticket.dict(by_alias=False))
    else:
        # 개인 포인트 적립
        m_user.point += 1
        db.users.update({"uid": uid}, m_user.dict(by_alias=False))

    # 적립 기록 레코드 갱신
    db.points.update({"_id": ObjectId(data_id)}, data.dict(by_alias=False))
    return m_user
