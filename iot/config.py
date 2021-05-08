import sys

from pydantic import BaseSettings

sys.path.append("../backend")


class MQTTSettings(BaseSettings):
    username: str
    password: str
    host: str
    port: int

    class Config:
        env_prefix = "MQTT_"


class APISettings(BaseSettings):
    base_url: str

    class Config:
        env_prefix = "API_"


mqtt_settings = MQTTSettings()
api_settings = APISettings()
