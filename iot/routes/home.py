from typing import Optional

import requests
from fastapi import APIRouter, FastAPI, Request, WebSocket
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


@router.get("/", response_class=HTMLResponse)
async def home(request: Request):
    title = "Dashboard"

    return templates.TemplateResponse(
        "home.html",
        {
            "request": request,
            "title": title,
        },
    )


@router.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    masterws[0] = websocket
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        await websocket.send_text(f"Message text was: {data}")


@router.get("/hello")
async def home(request: Request):
    await masterws[0].send_text("hellofrom")

    return "hello"


@router.get("/insert_cup")
async def home(request: Request):
    await masterws[0].send_text("inserted")

    return "hello"
