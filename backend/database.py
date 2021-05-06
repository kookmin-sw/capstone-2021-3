from config import app_settings, db_settings

if app_settings.test:
    # Test 모드 동작시에는 InMemory mongodb를 사용한다.
    from mongomock import MongoClient
else:
    from pymongo import MongoClient

my_client = None
if app_settings.test:
    my_client = MongoClient()
else:
    mongo_server = db_settings.url
    my_client = MongoClient(
        mongo_server,
        username=db_settings.username,
        password=db_settings.password,
    )

db = my_client[db_settings.name]
