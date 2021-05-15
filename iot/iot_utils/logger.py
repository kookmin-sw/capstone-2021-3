import logging

from fastapi.logger import logger as fastapi_logger

fastapi_logger.setLevel(logging.INFO)
logger = fastapi_logger
