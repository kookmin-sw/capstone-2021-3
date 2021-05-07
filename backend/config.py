from pydantic import BaseSettings

from utils.logger import logger


class AppSettings(BaseSettings):
    port: int = 8000
    test: bool = True

    class Config:
        # env_file = ".env"
        env_prefix = "APP_"


class DatabaseSettings(BaseSettings):
    url: str = "mongodb://localhost:27017/"
    username: str = "admin"
    password: str = "admin1234!"
    name: str = "next_generation"

    class Config:
        # env_file = ".env"
        env_prefix = "DB_"


class MQTTSettings(BaseSettings):
    username: str
    password: str
    host: str
    port: int
    class Config:
        # env_file = ".env"
        env_prefix = "MQTT_"


app_settings = AppSettings()
db_settings = DatabaseSettings()
mqtt_settings = MQTTSettings()

if app_settings.test:
    logger.warning("==========TEST 모드입니다.==========")
