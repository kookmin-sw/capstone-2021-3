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
