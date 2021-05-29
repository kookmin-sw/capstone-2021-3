import sys

sys.path.append("../backend")

from fastapi import FastAPI, HTTPException
from fastapi.staticfiles import StaticFiles
from utils.logger import logger

from iot_utils.database import DBType, db
from iot_utils.publisher import *
from mqtt_setting import *
from routes import admin, home

app = FastAPI(
    title="INOBUS IOT",
    description="INOBUS capstone project iot client",
    version="1.0.0",
    port=config.app_settings.port,
)

app.mount(
    "/static",
    StaticFiles(directory="static"),
    name="static",
)
app.include_router(
    router=home.router,
    prefix="",
    tags=["home"],
)
app.include_router(
    router=admin.router,
    prefix="/admin",
    tags=["admin"],
)

if mqtt.initialized:

    @app.on_event("startup")
    async def startup():
        logger.info("앱을 시작합니다.")
        await mqtt.app.connection()

    @app.on_event("shutdown")
    async def shutdown():
        logger.info("앱을 종료합니다.")
        await mqtt.app.client.disconnect()

    @app.post(
        "/point",
        description="포인트 적립",
    )
    async def point():
        data = await send_point_data()
        return HTTPException(201, data)

    @app.post(
        "/capacity",
        description="적재량 업데이트, ['water', 'plastic']",
    )
    async def capacity(sensor_type: str, sensor_value: float):
        if sensor_type.lower() not in ["water", "plastic"]:
            return HTTPException(400, f"{sensor_type} is not in ['water', 'plastic']")
        data = await send_capacity_data(sensor_type, sensor_value)
        return HTTPException(201, data)
