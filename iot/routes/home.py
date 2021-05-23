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

masterws = [None]

insert_data_id = [None]

base_url = config.api_settings.base_url

org_id = db.find_one(DBType.organization)
device_id = db.find_one(DBType.device)
org_id = "60901b909232116ad8c4f0d6"
device_id = "609a71f5f76202373c88040a"


@router.get("/", response_class=HTMLResponse)
async def home(request: Request):
    point = -1
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
    masterws[0] = websocket
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        op = data.split(":")[0]
        if op == "reward":
            print("code: " + data.split(":")[1])

            uid = data.split(":")[1]
            uid = "Mcw8DUx6mMRZRfJl3o1WzJRgqZK2"
            # data_id = db.find_one(DBType.last_point)
            data_id = "60a9f67f6dee8ef00ab0a4a4"

            res = requests.post(
                base_url + "/rewards/person_reward",
                params={"device_id": device_id, "uid": uid, "data_id": data_id},
            )
            print(res.url)
            print(res.text)
        await websocket.send_text(f"Message text was: {res.text}")
        # await websocket.send_text(f"Message text was: {data}")


@router.get("/hello")
async def home(request: Request):
    await masterws[0].send_text("hellofrom")

    return "hello"


@router.get("/insert_cup")
async def home(request: Request):
    try:
        await masterws[0].send_text("inserted")

        return "hello"
    except:
        return "no"


# @router.get("/insert_cup")
# async def home(request: Request):
#     res = requests.post(base_url+'/rewards/insert_cup', params = {'device_id': device_id})
#     res = json.loads(res.text)
#     if res['result'] == "success":
#         insert_data_id[0] = res['data_id']
#         try:
#             await masterws[0].send_text("inserted")

#             return "hello"
#         except:
#             return "no"
#     else:
#         return "device id error"
