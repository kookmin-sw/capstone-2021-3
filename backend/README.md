# INOBUS Backend

- [INOBUS Backend](#inobus-backend)
  - [폴더 및 파일 구조](#폴더-및-파일-구조)
  - [설치](#설치)
    - [개발용 패키지 설치](#개발용-패키지-설치)
    - [배포용 패키지 설치](#배포용-패키지-설치)
  - [실행](#실행)
    - [개발용 서버 실행하기](#개발용-서버-실행하기)
      - [Docker가 없는 경우](#docker가-없는-경우)
      - [Docker를 사용할 경우](#docker를-사용할-경우)
    - [배포용 서버 실행하기](#배포용-서버-실행하기)
  - [중지/제거 (docker-compose stop/down)](#중지제거-docker-compose-stopdown)
    - [중지 - 컨테이너 중지만 하고 삭제는 하지 않음](#중지---컨테이너-중지만-하고-삭제는-하지-않음)
    - [삭제 - 컨테이너 중지 및 제거 (stop & rm)](#삭제---컨테이너-중지-및-제거-stop--rm)
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
├── main.py                   # 애플리케이션 진입점
└── prestart-local.sh         # docker를 이용해서 local 서버를 실행시 처음 실행하는 스크립트
```

## 설치

### 개발용 패키지 설치

```shell
pip install -r requirements/development.txt
```

### 배포용 패키지 설치

```shell
pip install -r requirements/deployment.txt
```

## 실행

### 개발용 서버 실행하기

- 접속: http://localhost

#### Docker가 없는 경우

```shell
uvicorn main:app --env-file=.env.example --reload
```

#### Docker를 사용할 경우

```shell
docker-compose -f docker-compose.dev.yaml --env-file=.env.example up --build
```

### 배포용 서버 실행하기

1. [docker-compose.prod.yaml](./docker-compose.prod.yaml)와 [.env.example](.env.example)을 참고하여 .env 파일을 만든다.

2. Local DB를 사용하고 싶은 경우 아래 명령어로 mongodb를 실행한 후 .env 파일도 적절히 수정한다.
   ```shell
   docker-compose -f docker-compose.dev.yaml --env-file=.env.example up mongodb
   ```
3. 아래 명령어로 서버를 실행한다.
   ```shell
   docker-compose -f docker-compose.prod.yaml --env-file=.env up
   ```

## 중지/제거 (docker-compose stop/down)

### 중지 - 컨테이너 중지만 하고 삭제는 하지 않음

```shell
# 실행한 환경에 맞게 dev, prod 를 잘 적어준다.
docker-compose -f docker-compose.dev.yaml stop
docker-compose -f docker-compose.prod.yaml stop
```

### 삭제 - 컨테이너 중지 및 제거 (stop & rm)

```shell
# 실행한 환경에 맞게 dev, prod 를 잘 적어준다.
# -v 옵션을 적어줄 시 mongodb에 저장한 내용들(볼륨)도 삭제가 된다.
docker-compose -f docker-compose.dev.yaml down [-v]
docker-compose -f docker-compose.prod.yaml down [-v]
```

## API 문서 링크

- Swagger: http://localhost/docs
- Redoc: http://localhost/redoc

## Git hook 설정

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
