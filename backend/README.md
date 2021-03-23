# INOBUS Backend

- [INOBUS Backend](#inobus-backend)
  - [폴더 및 파일 구조](#폴더-및-파일-구조)
  - [설치](#설치)
    - [개발용 패키지 설치](#개발용-패키지-설치)
    - [배포용 패키지 설치](#배포용-패키지-설치)
  - [실행](#실행)
    - [Docker 없이 실행](#docker-없이-실행)
      - [개발용 서버 실행](#개발용-서버-실행)
      - [배포용 서버 실행 (권장 X, 테스트용)](#배포용-서버-실행-권장-x-테스트용)
    - [Docker compose를 이용한 실행](#docker-compose를-이용한-실행)
      - [Docker 이미지 빌드](#docker-이미지-빌드)
      - [Docker 이미지 배포](#docker-이미지-배포)
      - [개발용 서버 실행](#개발용-서버-실행-1)
      - [배포용 서버 실행](#배포용-서버-실행)
  - [중지/제거](#중지제거)
    - [중지 - 컨테이너 내부 상태는 유지 (파일들)](#중지---컨테이너-내부-상태는-유지-파일들)
    - [삭제 - 컨테이너 내부 상태까지 초기화](#삭제---컨테이너-내부-상태까지-초기화)
  - [Swagger 접속](#swagger-접속)

## 폴더 및 파일 구조

```
.
├── docker                    # Docker 관련 파일들을 모아둔 폴더
├── envs                      # 환경변수 관리하는 .env 폴더
├── models                    # API에 사용되는 모델들을 정의한 폴더
├── requirements              # 필요한 패키지들을 정의한 파일들을 모아둔 폴더
├── routes                    # API router 들을 정의한 폴더
├── utils                     # util 모음 폴더
├── database.py               # db 사용을 위한 파이썬 스크립트
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

### Docker 없이 실행

#### 개발용 서버 실행

- 접속: http://localhost:8000

```shell
uvicorn main:app --reload
```

#### 배포용 서버 실행 (권장 X, 테스트용)

- Docker 없이 배포하는 경우에는 gunicorn과 systemd 설정이 권장된다.
- 환경변수들을 미리 설정해두고 실행을 해야한다. [환경변수 목록 참고][.env.local]
- 접속: http://localhost

```shell
uvicorn main:app --host=0.0.0.0 --port=80
```

### Docker compose를 이용한 실행

- <이미지 이름:태그>에는 이미지를 빌드할 때 입력한 이미지 이름:태그를 사용 (ex. test:latest)

#### Docker 이미지 빌드

```shell
docker build . -f docker/Dockerfile -t <이미지 이름:태그>

# 또는 docker-compose 를 이용한 방법
docker-compose -f docker-compose.prod.yaml build
```

#### Docker 이미지 배포

- Docker 이미지는 github packages에 배포한다.
  - [Docker 저장소 주소](https://hub.docker.com/repository/docker/taejung/ino_api)
- packages 이용을 위한 Github token 만들기
  - 접속: https://github.com/settings/tokens
  - Generate new token 클릭
  - 아래의 권한 체크
    - write:packages
    - read:packages
    - delete:packages
  - 안전한 곳에 저장 (아래 예시에서는 token.txt에 저장)
- 수동 배포

  ```shell
  token.txt | docker login ghcr.io -u <Github username> --password-stdin
  docker tag <이미지 이름:태그> ghcr.io/aqudi/capstone_inobus_backend

  docker push ghcr.io/aqudi/capstone_inobus_backend

  # 또는 docker-compose 를 이용한 방법
  docker-compose -f docker-compose.prod.yaml push
  ```

- Github actions를 이용한 배포
  - Actions 파일 : [publish-backend-image.yml](.github\workflows\publish-backend-image.yml)
  - [참고링크1](https://docs.github.com/en/actions/guides/publishing-docker-images#publishing-images-to-github-packages), [참고링크2](https://docs.github.com/en/packages/guides/migrating-to-github-container-registry-for-docker-images#updating-your-github-actions-workflow)

#### 개발용 서버 실행

- [docker-compose.dev.yaml 참고](./docker-compose.dev.yaml)
- 파일을 수정하면 수정사항이 바로 반영된다.
- 접속: http://localhost:8000

```shell
# --build 옵션 사용 시 build도 함께 진행
docker-compose -f docker-compose.dev.yaml up [--build]
```

#### 배포용 서버 실행

- [docker-compose.prod.yaml 참고](./docker-compose.prod.yaml)
- [envs/.env.local][.env.local]을 참고하여 [envs/.env][.env]를 먼저 작성한다.
  - **주의: 이때 DOT_ENV=False 설정해준다.**
- 접속: http://localhost

```shell
# --build 옵션 사용 시 build도 함께 진행
docker-compose -f docker-compose.prod.yaml up [--build]
```

- Local DB를 사용하고 싶은 경우
  1. [envs/.env.local][.env.local]을 참고하여 [envs/.env][.env]를 작성한다.
  2. 아래 명령어로 mongodb 를 실행한 후 서버를 실행한다.

```shell
docker-compose -f docker-compose.dev.yaml up mongodb
```

## 중지/제거

### 중지 - 컨테이너 내부 상태는 유지 (파일들)

```shell
# 실행한 환경에 맞게 dev, prod 를 잘 적어준다.
docker-compose -f docker-compose.dev.yaml stop
docker-compose -f docker-compose.prod.yaml stop
```

### 삭제 - 컨테이너 내부 상태까지 초기화

```shell
# 실행한 환경에 맞게 dev, prod 를 잘 적어준다.
# -v 옵션을 적어줄 시 mongodb에 저장한 내용들도 삭제가 된다.
docker-compose -f docker-compose.dev.yaml down [-v]
docker-compose -f docker-compose.prod.yaml down [-v]
```

## Swagger 접속

http://localhost:8000/docs

[.env.local]: envs/.env.local
[.env]: envs/.env.local
