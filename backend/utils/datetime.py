from datetime import datetime, timezone, timedelta

KST = timezone(timedelta(hours=9))

datetime_format = "%Y-%m-%d %H:%M:%S"


def get_current_datetime_str() -> str:
    return datetime.now().strftime(datetime_format)


def parse_datetime_str(datetime_str: str) -> datetime:
    return datetime.strptime(datetime_str, datetime_format)


class DateTime(str):
    """datetime 포맷을 custom 하는 필드 클래스

    Reference: https://pydantic-docs.helpmanual.io/usage/types/#custom-data-types
    """

    @classmethod
    def __get_validators__(cls):
        yield cls.validate

    @classmethod
    def __modify_schema__(cls, field_schema):
        field_schema.update(type="string")

    @classmethod
    def validate(cls, v):
        if not isinstance(v, str):
            raise TypeError("string required")

        try:
            m = parse_datetime_str(v.upper())
            return cls(m)
        except ValueError as e:
            # Datetime format error
            raise e
