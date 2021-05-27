import json
from typing import Optional

import requests
from fastapi import APIRouter, FastAPI, Request, WebSocket, params
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from starlette.responses import RedirectResponse
from utils.logger import logger

from config import config
from iot_utils.database import DBType, db
from mqtt_setting import mqtt

templates = Jinja2Templates(directory="templates")

router = APIRouter()

base_url = config.api_settings.base_url

org_id = db.find_one(DBType.organization)
device_id = db.find_one(DBType.device)


@router.get("/", response_class=HTMLResponse)
async def home(request: Request):
    point = 0
    res = requests.get(base_url + "/organizations")
    res = json.loads(res.text)
    for i in res:
        if i["_id"] == org_id:
            point = i["point"]

    return templates.TemplateResponse(
        "home.html",
        {
            "request": request,
            "point": point,
        },
    )


@router.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    config.ws = websocket
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        op = data.split(":")[0]
        if op == "reward":
            print("code: " + data.split(":")[1])

            uid = data.split(":")[1]
            data_id = db.find_one(DBType.last_point)

            res = requests.post(
                base_url + "/rewards/person_reward",
                params={"device_id": device_id, "uid": uid, "data_id": data_id},
            )
        await websocket.send_text(f"Message text was: {res.text}")

@router.get("/hello")
async def hello(data:str):
    op = data.split(":")[0]
    if op == "reward":
        print("code: " + data.split(":")[1])

        uid = data.split(":")[1]
        data_id = db.find_one(DBType.last_point)

        res = requests.post(
            base_url + "/rewards/person_reward",
            params={"device_id": device_id, "uid": uid, "data_id": data_id},
        )
    await config.ws.send_text(f"Message text was: {res.text}")

