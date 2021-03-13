from fastapi import FastAPI

from routes import devices, organizations, users

app = FastAPI()

app.include_router(
    router=organizations.router,
    prefix="/organizations",
    tags=["organization"],
)

app.include_router(
    router=devices.router,
    prefix="/devices",
    tags=["devices"],
)

app.include_router(
    router=users.router,
    prefix="/users",
    tags=["users"],
)
