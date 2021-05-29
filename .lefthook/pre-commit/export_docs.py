import json
import os
import subprocess
import sys
from pathlib import Path

backend_root = Path(__name__).parent.absolute() / "backend"
sys.path.append(str(backend_root.resolve()))
sys.path.append(str((backend_root / "venv/lib/site-packages").resolve()))

from main import app

HTML_TEMPLATE = """<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>My Project - ReDoc</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="https://fastapi.tiangolo.com/img/favicon.png">
    <style>
        body {
            margin: 0;
            padding: 0;
        }
    </style>
    <style data-styled="" data-styled-version="4.4.1"></style>
</head>
<body>
    <div id="redoc-container"></div>
    <script src="https://cdn.jsdelivr.net/npm/redoc/bundles/redoc.standalone.js"> </script>
    <script>
        var spec = %s;
        Redoc.init(spec, {}, document.getElementById("redoc-container"));
    </script>
</body>
</html>
"""

if __name__ == "__main__":
    with open(f"backend/docs.html", "w") as fd:
        print(HTML_TEMPLATE % json.dumps(app.openapi()), file=fd)
    subprocess.check_call(["git", "add", "backend/docs.html"])
