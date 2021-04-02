from pydantic import BaseSettings


class DeviceSettings(BaseSettings):
    device_name: str
    organization_name: str
    host: str
    port: int

    class Config:
        env_file = ".env"
        env_prefix = "IOT_"


class MQTTSettings(BaseSettings):
    username: str
    password: str
    host: str
    port: int

    class Config:
        env_file = ".env"
        env_prefix = "MQTT_"
        fields = {
            "password": {
                "env": "MQTT_PASS",
            },
        }


class APISettings(BaseSettings):
    base_url: str

    class Config:
        env_file = ".env"
        fields = {"base_url": {"env": "API_BASE_URL"}}


device_settings = DeviceSettings()
mqtt_settings = MQTTSettings()
api_settings = APISettings()