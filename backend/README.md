# INOBUS Backend

- [INOBUS Backend](#inobus-backend)
  - [폴더 및 파일 구조](#폴더-및-파일-구조)
  - [사전준비](#사전준비)
    - [배포 필수 요구사항](#배포-필수-요구사항)
  - [실행](#실행)
    - [개발용 서버 실행하기](#개발용-서버-실행하기)
    - [배포용 환경으로 개발용 서버 실행하기](#배포용-환경으로-개발용-서버-실행하기)
    - [컨테이너 중지 및 제거하기](#컨테이너-중지-및-제거하기)
  - [배포](#배포)
  - [개발](#개발)
    - [API 문서 링크](#api-문서-링크)
    - [Git hook 설정](#git-hook-설정)

## 폴더 및 파일 구조

```
.
├── docker                    # Docker 관련 파일들을 모아둔 폴더
├── models                    # API에 사용되는 모델들을 정의한 폴더
├── requirements              # 필요한 패키지들을 정의한 파일들을 모아둔 폴더
├── routes                    # API router 들을 정의한 폴더
├── utils                     # util 모음 폴더
├── .env.example              # 환경변수 예시 파일
├── config.py                 # 설정을 관리하는 폴더
├── database.py               # DB 연결 객체를 제공해주는 파일
├── docker-compose.dev.yaml   # 개발용 docker-compose 파일
├── docker-compose.prod.yaml  # 배포용 docker-compose 파일
├── docs.html                 # 호스팅용 API 문서 파일
├── gunicorn_conf.py          # 배포 시 사용하는 gunicorn 설정을 정의하는 파일
├── main_consumer.py          # IOT 디바이스와 DB를 연결해주는 Consumer 진입점
├── main.py                   # 애플리케이션 진입점
└── prestart.sh               # docker를 이용해서 서버 실행시 처음 실행하는 스크립트
```

## 사전준비

- python 3.8 이상
- [(옵션) docker 최신버전](https://www.docker.com/get-started)

### 배포 필수 요구사항

- [aws cli v2](https://www.google.com/search?q=aws+cli+v2&oq=aws+cli+v2&aqs=chrome..69i57j69i64l2j69i60l3j0l2&sourceid=chrome&ie=UTF-8)

## 실행

### 개발용 서버 실행하기

- 파일 변경을 감지하여 자동으로 재실행해주는 기능 포함
- 서버 URL: http://localhost
- Flags
  - -d: daemon 모드로 실행
  - --build: docker 이미지 빌드 후 실행

```shell
docker context use default
docker compose -f docker-compose.dev.yaml --env-file=.env.example [-d] up [--build]
```

### 배포용 환경으로 개발용 서버 실행하기

- Python WSGI HTTP Server gunicorn을 사용하여 배포
- Awsgi worker인 uvicorn worker를 사용
- Flags
  - -d: daemon 모드로 실행
  - --build: docker 이미지 빌드 후 실행

1. ecs local context 생성 (ECS 환경을 로컬에서 시뮬레이션할 수 있게 도와줌)
   ```shell
   docker context create ecs --local-simulation ecsLocal
   docker context use ecsLocal
   ```
2. [docker-compose.prod.yaml](./docker-compose.prod.yaml)와 [.env.example](.env.example)을 참고하여 .env 파일 작성

3. 아래 명령어로 서버를 실행
   ```shell
   docker compose -f docker-compose.prod.yaml --env-file=.env [-d] up [--build]
   ```

### 컨테이너 중지 및 제거하기

- 현재 실행중인 서비스 컨테이너들 중지

  ```shell
  docker compose -f <compose file name> stop
  ```

- 현재 실행중이지 않은 서비스 컨테이너들 제거

  ```shell
  docker compose -f <compose file name> rm
  ```

- 정의된 서비스들의 컨테이너 중지 및 제거

  ```shell
  docker compose -f <compose file name> down
  ```

## 배포

1. docker ecs context 생성 및 AWS Profile 입력

   ```shell
   docker context create ecs contextName
   docker context use contextName
   ```

2. 컨테이너 레지스트리 ECR 로그인

   ```shell
   aws ecr get-login-password --region us-west-2 |
    docker login --username AWS --password-stdin 573620237252.dkr.ecr.us-west-2.amazonaws.com/inobus
   ```

3. .env file 작성

   - [docker-compose.prod.yaml](./docker-compose.prod.yaml)과 [.env.example](./.env.example)을 참고하여 작성
   - RABBITMQ의 Password는 [스크립트](./docker/rabbitmq/generate_password.py)를 활용하여 생성

   ```shell
   cp .env.example .env
   ```

4. Docker image build

   ```shell
   docker context use default
   docker compose -f docker-compose.prod.yaml --env-file .env build
   ```

5. Docker image를 ECR로 push

   ```shell
   docker context use default
   docker compose -f docker-compose.prod.yaml --env-file .env push
   ```

6. Docker cli를 통해 AWS CloudFormation으로 배포

   ```shell
   docker context use contextName
   docker compose -f docker-compose.prod.yaml --env-file .env up
   ```

## 개발

### API 문서 링크

- Swagger: http://localhost/docs
- Redoc: http://localhost/redoc

### Git hook 설정

- lefthook 설치
  - [lefthook 설치 가이드](https://github.com/Arkweid/lefthook/blob/master/docs/full_guide.md)
  - Windows 10은 [release](https://github.com/Arkweid/lefthook/releases)에서 다운 받은 후 환경변수에 지정
  - lefthook.yml 있는 폴더에서 `lefthook install` 실행
- lefthook-local.yml 파일 작성
  ```yml
  pre-push:
    exclude_tags:
      - app
      - iot
  pre-commit:
    exclude_tags:
      - app
      - iot
  ```
