from fastapi import FastAPI
from fastapi.routing import APIRouter

from routes import devices, organizations, users
from routes.mqtt import mqtt
from routes.mqtt import router as mqtt_router

app = FastAPI(
    title="INOBUS API",
    description="INOBUS capstone project api",
    version="1.0.0",
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

mqtt.init_app(app)
router.include_router(
    router=mqtt_router,
    prefix="/mqtt",
    tags=["mqtt"],
)

app.include_router(router)
