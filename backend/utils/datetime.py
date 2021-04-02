from datetime import datetime, timezone, timedelta

KST = timezone(timedelta(hours=9))


def get_current_datetime_str() -> str:
    now = datetime.now(tz=KST)
    return str(now)


def get_datetime_obj_from_str(date: str) -> datetime:
    return datetime.fromisoformat(date)
