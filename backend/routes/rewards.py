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
    device = db.devices.find_one({"_id": device_id})
    if device:
        device['point'] += 1
        db.devices.update({"_id": device_id}, device)
    else:
        raise HTTPException(status_code=404, detail="Device not found")

    org_name = device['organization']


    # 단체 포인트 적립
    organization = db.organizations.find_one({"name": org_name})
    organization['point'] += 1
    db.organizations.update({"name": org_name}, organization)


    # 적립 기록 레코드 생성
    res = db.points.insert_one({"device": device_id, "date": get_current_datetime_str()})

    ret = dict()
    ret['result'] = 'success'
    ret['data_id'] = str(res.inserted_id)


    return ret



@router.get(
    "/person_reward",
    response_model=UserOut,
    description="쓰샘기기에서 코드를 통해 포인트 적립",
)
async def person_reward(device_id: str, uid: str, data_id: str):

    # 포인트 데이터 조회
    data = db.points.find_one({"_id": ObjectId(data_id)})
    if not data:
        raise HTTPException(status_code=404, detail="Access denied")
    if data['device'] != device_id:
        raise HTTPException(status_code=404, detail="Access denied")
    data['user'] = uid
    data['reward_date'] = get_current_datetime_str()

    # Firebase 조회
    try:
        user = auth.get_user(uid)
    except firebase_admin._auth_utils.UserNotFoundError:
        raise HTTPException(status_code=404, detail="User not found")
    except Exception as e:
        raise HTTPException(status_code=404, detail="Firebase Error: "+ e)

    # 개인 포인트 적립
    m_user = db.users.find_one({"_id": uid})
    if m_user:
        m_user['point'] += 1
        db.users.update({"_id": uid}, m_user)
    else:
        db.users.update({"_id": uid}, {"user_name": user.display_name, "point": 1}, upsert=True)
    
    # 적립 기록 레코드 갱신
    db.point.update({"_id": data_id}, data)


    return db.users.find_one({"_id": uid})

