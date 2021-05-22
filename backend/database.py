from config import config

if config.app_settings.test:
    # Test 모드 동작시에는 InMemory mongodb를 사용한다.
    from mongomock import MongoClient
else:
    from pymongo import MongoClient

my_client = None
if config.app_settings.test:
    my_client = MongoClient()
else:
    mongo_server = config.db_settings.url
    my_client = MongoClient(
        mongo_server,
        username=config.db_settings.username,
        password=config.db_settings.password,
    )

db = my_client[config.db_settings.name]
