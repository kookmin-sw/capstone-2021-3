from functools import cached_property

from pydantic import BaseSettings


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
    username: str = "admin"
    password: str = "admin1234!"
    host: str = "localhost"
    port: int = "18820"

    class Config:
        # env_file = ".env"
        env_prefix = "MQTT_"


class Config:
    @cached_property
    def app_settings(self):
        return AppSettings()

    @cached_property
    def mqtt_settings(self):
        return MQTTSettings()

    @cached_property
    def db_settings(self):
        return DatabaseSettings()


config = Config()
