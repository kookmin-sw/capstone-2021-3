from datetime import datetime


def get_current_datetime_str() -> str:
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S %p")


def get_datetime_obj_from_str(date: str) -> datetime:
    return datetime.strptime(date, "%Y-%m-%d %H:%M:%S %p")
