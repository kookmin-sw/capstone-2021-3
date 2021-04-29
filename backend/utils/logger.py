try:
    from uvicorn.config import logger as uvicorn_logger

    logger = uvicorn_logger
except:
    import logging

    logger = logging.getLogger()
