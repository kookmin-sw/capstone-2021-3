FROM tiangolo/uvicorn-gunicorn-fastapi:python3.8-alpine3.10

# Guniocorn 설정 파일
ENV GUNICORN_CONF="/app/gunicorn_conf.py"

# 배포할 host와 port
ENV BIND="0.0.0.0:8080"

# Gunicorn 로그 설정
ENV ACCESS_LOG="-"
ENV ERROR_LOG="-"
ENV LOG_LEVEL="warning"

# 파일 복사 및 패키지 설치
COPY . /app
WORKDIR /app
RUN pip install --no-cache-dir -r requirements/deployment.txt
