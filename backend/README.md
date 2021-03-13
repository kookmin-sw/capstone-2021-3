# INOBUS Backend

## 폴더 구조

```
.
├── main.py  # 애플리케이션 진입점
├── models   # API에 사용되는 모델들을 정의한 폴더
├── routes   # API router 들을 정의한 폴더
└── utils    # util 모음 폴더
```

## 설치

```shell
pip install -r requirements.txt
```

## 실행

```shell
uvicorn main:app
```

## Swagger 접속
http://localhost:8000/docs
