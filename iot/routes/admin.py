from typing import Optional

import requests
from fastapi import APIRouter, Request
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from starlette.responses import RedirectResponse
from utils.logger import logger

from config import config
from iot_utils.database import DBType, db
from mqtt_setting import mqtt

templates = Jinja2Templates(directory="templates")

router = APIRouter()


@router.get("/", response_class=HTMLResponse)
async def dashboard(request: Request):
    title = "Dashboard"

    organization = db.find_one(DBType.organization)
    device = db.find_one(DBType.device)

    return templates.TemplateResponse(
        "dashboard.html",
        {
            "request": request,
            "title": title,
            "organization": organization,
            "device": device,
        },
    )


@router.get("/reconnect")
async def redirect_admin(request: Request):
    await mqtt.re_initialize()
    return RedirectResponse("/admin")


@router.get("/settings", response_class=HTMLResponse)
async def settings(
    request: Request,
    query_type: Optional[str] = None,
    organization_idx: Optional[int] = None,
    device_idx: Optional[int] = None,
):
    title = "Settings"
    status_code = 200
    ctx = {
        "request": request,
        "title": title,
        "query_type": query_type,
    }
    try:
        # Cache 지우기
        if query_type == "remove_cache":
            db.truncate()
        # 기관 리스트 검색
        elif query_type == "organization":
            # 캐싱 유무 검사
            organization_list = db.find_one(DBType.organization_list)
            if organization_list:
                organization_list = organization_list
            else:
                # 없을 시 네트워크로 데이터 패치
                logger.info("기관 정보를 네트워크에서 받아옵니다.")
                res = requests.get(f"{config.api_settings.base_url}/organizations")
                organization_list = res.json()
                db.upsert(DBType.organization_list, organization_list)
                db.remove(DBType.device_list)

            ctx["organizations"] = organization_list

        # 기관에 속한 디바이스 리스트 검색
        elif query_type == "device":
            # 기관 정보
            organization_list = db.find_one(DBType.organization_list)
            organization = organization_list[organization_idx]
            old_organization = db.find_one(DBType.organization)

            # 기존 정보랑 다를 때 upsert 및 device 정보 갱신
            if old_organization != organization:
                db.upsert(DBType.organization, organization)
                db.remove(DBType.device_list)

            # 기관에 속한 디바이스 정보 캐싱 검사 -> 네트워크 요청
            device_list = db.find_one(DBType.device_list)
            if device_list:
                device_list = device_list
            else:
                # 없을 시 네트워크로 데이터 패치
                logger.info("디바이스 정보를 네트워크에서 받아옵니다.")
                res = requests.get(
                    f"{config.api_settings.base_url}/organizations/{organization.get('_id')}/devices"
                )
                device_list = res.json()
                db.upsert(DBType.device_list, device_list)

            ctx["organization"] = organization
            ctx["devices"] = device_list

        # 디바이스 정보 저장
        elif query_type == "registration" and device_idx != None:
            device_list = db.find_one(DBType.device_list)
            logger.info(device_list)
            device = device_list[device_idx]
            logger.info(device)
            db.upsert(DBType.device, device)
            return RedirectResponse("reconnect")

    except requests.exceptions.ConnectionError as e:
        ctx["error"] = "API 서버와 연결을 실패했습니다."
        status_code = 500
        logger.error(f"{ctx['error']}, {e}")
    except Exception as e:
        ctx["error"] = "알 수 없는 에러가 발생했습니다."
        status_code = 500
        logger.error(f"{ctx['error']}, {e}")

    return templates.TemplateResponse("settings.html", ctx, status_code=status_code)
