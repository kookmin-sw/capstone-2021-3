from enum import Enum
from typing import Any

from tinydb import Query, TinyDB
from tinydb.operations import delete
from utils.logger import logger


class DBType(str, Enum):
    organization_list = "olist"
    device_list = "dlist"
    organization = "o"
    device = "d"


class DB:
    def __init__(self):
        self._db = TinyDB(".db.json")
        self.query = Query()

    @property
    def db(self):
        return self._db.table("info")

    def find(self, db_type: DBType):
        try:
            logger.info(f"DB find: {db_type.value}")
            result = self.db.search(self.query.type == db_type)
            result = list(map(lambda x: x["value"], result))
            return result
        except Exception as e:
            logger.error(f"디비에러: {e}")
        return []

    def find_one(self, db_type: DBType):
        try:
            return self.find(db_type)[0]
        except:
            None

    def upsert(self, db_type: DBType, data: Any):
        try:
            logger.info(f"DB upsert: {db_type.value}")
            data = {"type": db_type.value, "value": data}
            if self.find(db_type):
                return self.db.update(data, self.query.type == db_type)
            return self.db.insert(data)
        except Exception as e:
            logger.error(f"디비에러: {e}")

    def remove(self, db_type: DBType):
        try:
            logger.info(f"DB remove: {db_type.value}")
            item = self.db.get(self.query.type == db_type)
            return self.db.remove(doc_ids=[item.doc_id])
        except Exception as e:
            logger.error(f"디비에러: {e}")

    def truncate(self):
        try:
            logger.info("DB 초기화")
            self.db.truncate()
        except Exception as e:
            logger.error(f"디비에러: {e}")


db = DB()
