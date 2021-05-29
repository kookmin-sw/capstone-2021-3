from fastapi import FastAPI
from fastapi.routing import APIRouter

from config import config
from routes import devices, organizations, rewards, users
from utils.logger import logger

app = FastAPI(
    title="INOBUS API",
    description="INOBUS capstone project api",
    version="1.0.0",
    port=config.app_settings.port,
)

router = APIRouter(prefix="/api/v1")

router.include_router(
    router=organizations.router,
    prefix="/organizations",
    tags=["organization"],
)

router.include_router(
    router=devices.router,
    prefix="/devices",
    tags=["devices"],
)

router.include_router(
    router=users.router,
    prefix="/users",
    tags=["users"],
)

router.include_router(
    router=rewards.router,
    prefix="/rewards",
    tags=["rewards"],
)

app.include_router(router)


@app.get("/ping")
async def ping():
    return "pong"


if config.app_settings.test:
    logger.warning("==========TEST 모드입니다.==========")
