from functools import cached_property

from pydantic import BaseSettings


class AppSettings(BaseSettings):
    port: int = 8000
    test: bool = True
    log_level: str = "DEBUG"

    class Config:
        # env_file = ".env"
        env_prefix = "APP_"


class MQTTSettings(BaseSettings):
    username: str = "admin"
    password: str = "admin1234!"
    host: str = "localhost"
    port: int = "18820"

    class Config:
        # env_file = ".env"
        env_prefix = "MQTT_"


class APISettings(BaseSettings):
    base_url: str

    class Config:
        env_prefix = "API_"


class Config:
    @cached_property
    def app_settings(self):
        return AppSettings()

    @cached_property
    def mqtt_settings(self):
        return MQTTSettings()

    @cached_property
    def api_settings(self):
        return APISettings()


config = Config()
