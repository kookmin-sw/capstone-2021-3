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
    "/insert_cup",
    description="쓰샘기기에 재활용컵 투입시 등록",
)
async def insert_cup(device_id: str):

    # 기기 포인트 적립
    device = db.devices.find_one({"_id": ObjectId(device_id)})
    if device:
        device = Device.parse_obj(device)
        device.point += 1
        db.devices.update({"_id": ObjectId(device_id)}, device.dict(by_alias=False))
    else:
        raise HTTPException(status_code=404, detail="Device not found")

    # org_name = device.organization

    # 단체 포인트 적립
    organization = db.organizations.find_one({"_id": device.organization})
    organization = Organization.parse_obj(organization)
    organization.point += 1
    db.organizations.update(
        {"_id": device.organization}, organization.dict(by_alias=False)
    )

    # 적립 기록 레코드 생성
    res = db.points.insert_one(
        {"device": ObjectId(device_id), "date": get_current_datetime_str()}
    )

    ret = dict()
    ret["result"] = "success"
    ret["data_id"] = str(res.inserted_id)

    return ret


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
        raise HTTPException(status_code=404, detail="Access denied")
    data = PointData.parse_obj(data)
    # device_id 검사
    if data.device != ObjectId(device_id):
        print("Access denied: device_id is not matched!")
        raise HTTPException(status_code=404, detail="Access denied")
    # 중복 요청 검사
    if data.user:
        print("Access denied: Already rewarded!")
        raise HTTPException(status_code=404, detail="Access denied")
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
        raise HTTPException(status_code=404, detail=result)

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


##테스트데이터
@router.get(
    "/make",
    description="테스트데이터",
)
async def organization_detail():
    db.organizations.update(
        {"_id": ObjectId("60901b909232236ad8c4f0d6")},
        {
            "_id": ObjectId("60901b909232236ad8c4f0d6"),
            "name": "국민대학교",
            "point": 0,
            "homepage": "http://kookmin.ac.kr/",
            "phone": "02-910-4114",
        },
        upsert=True,
    )
    db.devices.update(
        {"_id": ObjectId("10901b909232236ad8c4f0d6")},
        {
            "_id": ObjectId("10901b909232236ad8c4f0d6"),
            "name": "국민쓰샘1호",
            "model": "model_1",
            "organization": ObjectId("60901b909232236ad8c4f0d6"),
            "install_date": get_current_datetime_str(),
            "latitude": 37.61090337619938,
            "longitude": 126.99727816928652,
            "location_description": "국민대학교 미래관 4층 자율주행스튜디오 앞",
            "point": 377,
        },
        upsert=True,
    )

    print(list(db.organizations.find()))
    print(list(db.devices.find()))
    return "ss"
