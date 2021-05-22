import firebase_admin
from firebase_admin import auth

from database import db
from models.user import UserOut

default_app = firebase_admin.initialize_app()

def get_user(uid):
    try:
        user = auth.get_user(uid)
    except firebase_admin._auth_utils.UserNotFoundError:
        return "User not found", None
    except Exception as e:
        return "Firebase Error: "+ str(e), None

    
    m_user = db.users.find_one({"uid": uid})
    # 최초 등록시
    if not m_user:
        db.users.update({"uid": uid}, {"uid": uid, "user_name": user.display_name, "point": 0}, upsert=True)
        m_user = db.users.find_one({"uid": uid})
    
    m_user = UserOut.parse_obj(m_user)


    return "success", m_user