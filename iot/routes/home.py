import requests
from fastapi import APIRouter, Request, WebSocket
from fastapi.responses import HTMLResponse
from fastapi.templating import Jinja2Templates
from fastapi.websockets import WebSocketDisconnect
from utils.logger import logger

from config import config
from iot_utils.database import DBType, db
from mqtt_setting import mqtt
from websocket_manager import websocket_manager

templates = Jinja2Templates(directory="templates")

router = APIRouter()


@router.get("/", response_class=HTMLResponse)
async def home(request: Request):
    point = -1
    organization = mqtt.get_organization_info()
    try:
        point = organization["point"]
    except:
        pass
    return templates.TemplateResponse(
        "home.html",
        {
            "request": request,
            "point": point,
        },
    )


@router.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket_manager.connect(websocket)
    try:
        while True:
            data = await websocket.receive_text()
            op = data.split(":")[0]
            if op == "reward":
                print("code: " + data.split(":")[1])

                uid = data.split(":")[1]
                data_id = db.find_one(DBType.last_point)

                res = requests.post(
                    config.api_settings.base_url + "/rewards/person_reward",
                    params={
                        "device_id": mqtt.device_id,
                        "uid": uid,
                        "data_id": data_id,
                    },
                )
            await websocket_manager.send_personal_message(
                f"Message text was: {res.text}", websocket
            )
            await websocket_manager.broadcast(f"Client #{websocket} says: {data}")
    except WebSocketDisconnect:
        print("Hello")
        websocket_manager.disconnect(websocket)
        await websocket_manager.broadcast(f"Client #{websocket} left the chat")
