from datetime import datetime

import firebase_admin
from bson import ObjectId
from fastapi import APIRouter, HTTPException
from firebase_admin import auth

from database import db
from models.user import UserOut
from utils.datetime import get_current_datetime_str

router = APIRouter()

default_app = firebase_admin.initialize_app()


@router.post(
    "/insert_cup",
    description="쓰샘기기에 재활용컵 투입시 등록",
)
async def insert_cup(device_id: str):

    # 기기 포인트 적립
    device = db.devices.find_one({"_id": ObjectId(device_id)})
    if device:
        device['point'] += 1
        db.devices.update({"_id": ObjectId(device_id)}, device)
    else:
        raise HTTPException(status_code=404, detail="Device not found")

    org_name = device['organization']


    # 단체 포인트 적립
    organization = db.organizations.find_one({"name": org_name})
    organization['point'] += 1
    db.organizations.update({"name": org_name}, organization)


    # 적립 기록 레코드 생성
    res = db.points.insert_one({"device": ObjectId(device_id), "date": get_current_datetime_str()})

    ret = dict()
    ret['result'] = 'success'
    ret['data_id'] = str(res.inserted_id)


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
    # device_id 검사
    if data['device'] != ObjectId(device_id):
        print("Access denied: device_id is not matched!")
        raise HTTPException(status_code=404, detail="Access denied")
    # 중복 요청 검사
    if 'user' in data:
        print("Access denied: Already rewarded!")
        raise HTTPException(status_code=404, detail="Access denied")
    data['user'] = uid
    data['reward_date'] = get_current_datetime_str()
    
    # Firebase 조회
    try:
        user = auth.get_user(uid)
    except firebase_admin._auth_utils.UserNotFoundError:
        print("Access denied: User not found!")
        raise HTTPException(status_code=404, detail="Access denied")
    except Exception as e:
        raise HTTPException(status_code=404, detail="Firebase Error: "+ str(e))

    
    # 기기ID로 기관 조회
    device = db.devices.find_one({"_id": ObjectId(device_id)})
    org_name = device['organization']
    organization = db.organizations.find_one({"name": org_name})


    # 당월 티켓발행수 조회
    thismonth = int(datetime.today().strftime("%Y%m"))
    num_tickets = len(list(db.tickets.find({"user": uid, "yearmonth": thismonth})))

    
    m_user = db.users.find_one({"_id": uid})
    # 최초 등록시
    if not m_user:
        db.users.update({"_id": uid}, {"user_name": user.display_name, "point": 0}, upsert=True)
        m_user = db.users.find_one({"_id": uid})

    if num_tickets < 3:
        # 추첨권 발행
        db.tickets.insert_one({"organization": ObjectId(organization['_id']), "user": uid, "date": get_current_datetime_str(), "yearmonth": thismonth})
    else:
        # 개인 포인트 적립
            m_user['point'] += 1
            db.users.update({"_id": uid}, m_user)
        
    # 적립 기록 레코드 갱신
    db.points.update({"_id": ObjectId(data_id)}, data)

    return db.users.find_one({"_id": uid})
