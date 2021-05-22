import logging
import sys

from loguru import logger

from config import config


class InterceptHandler(logging.Handler):
    """라이브러리에서 호출하는 로그들을 Intercept 한다.

    참고: https://github.com/Delgan/loguru"""

    def emit(self, record):
        # Get corresponding Loguru level if it exists
        try:
            level = logger.level(record.levelname).name
        except ValueError:
            level = record.levelno

        # Find caller from where originated the logged message
        frame, depth = logging.currentframe(), 2
        while frame.f_code.co_filename == logging.__file__:
            frame = frame.f_back
            depth += 1

        logger.opt(depth=depth, exception=record.exc_info).log(
            level, record.getMessage()
        )


log_level = config.app_settings.log_level
logging.root.setLevel(log_level)

intercept_handler = InterceptHandler()
logger_set = set(
    [
        *logging.root.manager.loggerDict.keys(),
        "gunicorn",
        "gunicorn.access",
        "gunicorn.error",
        "uvicorn",
        "uvicorn.access",
        "uvicorn.error",
    ]
)
for name in logger_set:
    logging.getLogger(name).propagate = False
    logging.getLogger(name).handlers = [intercept_handler]

logger.configure(handlers=[{"sink": sys.stdout, "serialize": False}])
