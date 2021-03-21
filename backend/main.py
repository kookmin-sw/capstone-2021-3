from fastapi import FastAPI
from fastapi.routing import APIRouter

from routes import devices, organizations, users

app = FastAPI(
    title="INOBUS API",
    description="INOBUS capstone project api",
    version="1.0.0",
)

router = APIRouter(
    prefix="/api/v1"
)

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

app.include_router(router);