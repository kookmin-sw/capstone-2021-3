import os
from io import StringIO
from pathlib import Path


def get_dot_env():
    DOT_ENV = os.getenv("DOT_ENV", "True").lower() in ["true", "1"]
    DOCS = os.getenv("DOCS", "False").lower() in ["true", "1"]
    if DOT_ENV or DOCS:
        import dotenv

        envfile_path = Path(__name__).parent
        envfile_path /= Path("backend/envs/.env.local")
        with envfile_path.absolute().open(encoding="utf-8") as f:
            dotenv.load_dotenv(stream=StringIO(f.read()))
