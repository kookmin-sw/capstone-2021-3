import os

from utils.get_dot_env import get_dot_env

if os.getenv("DOCS", "False").lower() in ["true", "1"]:
    # export_docs.py 실행 중에는 in memory mongodb 를 사용한다.
    from mongomock import MongoClient
else:
    from pymongo import MongoClient

get_dot_env()


my_client = None
if os.getenv("DOCS", "False").lower() in ["true", "1"]:
    my_client = MongoClient()
else:
    mongo_server = os.getenv("DB_URL")
    my_client = MongoClient(
        mongo_server,
        username=os.getenv("DB_USERNAME"),
        password=os.getenv("DB_PASSWORD"),
    )

db = my_client[os.getenv("DB_NAME")]
