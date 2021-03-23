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
    - [Docker를 이용한 실행](#docker를-이용한-실행)
      - [Docker 이미지 빌드](#docker-이미지-빌드)
      - [Docker 이미지 배포](#docker-이미지-배포)
      - [개발용 서버 실행](#개발용-서버-실행-1)
      - [배포용 서버 실행](#배포용-서버-실행)
  - [API 문서 링크 (개발)](#api-문서-링크-개발)
  - [Git hook 설정](#git-hook-설정)

## 폴더 및 파일 구조

```
.
├── docker              # Docker 관련 파일들을 모아둔 폴더
├── gunicorn_conf.py    # 배포 시 사용하는 gunicorn 설정을 정의하는 파일
├── main.py             # 애플리케이션 진입점
├── models              # API에 사용되는 모델들을 정의한 폴더
├── requirements        # 필요한 패키지들을 정의한 파일들을 모아둔 폴더
├── routes              # API router 들을 정의한 폴더
└── utils               # util 모음 폴더
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

```shell
uvicorn main:app --reload
```

#### 배포용 서버 실행 (권장 X, 테스트용)

- Docker 없이 배포하는 경우에는 gunicorn과 systemd 설정이 권장된다.

```shell
uvicorn main:app --host=0.0.0.0 --port=80
```

### Docker를 이용한 실행

- <이미지 이름:태그>에는 이미지를 빌드할 때 입력한 이미지 이름:태그를 사용 (ex. test:latest)

#### Docker 이미지 빌드

```shell
docker build . -f docker/Dockerfile -t <이미지 이름:태그>
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
  ```
- Github actions를 이용한 배포
  - Actions 파일 : [publish-backend-image.yml](.github\workflows\publish-backend-image.yml)
  - [참고링크1](https://docs.github.com/en/actions/guides/publishing-docker-images#publishing-images-to-github-packages), [참고링크2](https://docs.github.com/en/packages/guides/migrating-to-github-container-registry-for-docker-images#updating-your-github-actions-workflow)

#### 개발용 서버 실행

```shell
docker run --name api-dev -p 80:80 -v ${pwd}:/app <이미지 이름:태그> /start-reload.sh
```

#### 배포용 서버 실행

- `-d`: 백그라운드에서 컨테이너 실행
- `--restart unless-stopped`: container stop 하기 전까지 항상 재시작하는 정책 사용

```shell
# --reload 는 개발할 때 사용
uvicorn main:app --reload
```

## API 문서 링크 (개발)

- [Swagger](http://localhost:8000/docs)
- [Redoc](http://localhost:8000/redoc)

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
  pre-commit:
    exclude_tags:
      - app
  ```
