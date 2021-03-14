from datetime import datetime


def get_current_datetime_str() -> str:
    return datetime.now().strftime("%Y-%M-%d %I:%M:%S %p")
