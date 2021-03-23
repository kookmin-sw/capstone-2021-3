# INOBUS Application

## 폴더 구조

```
TBD
```

## 설치

1. flutter 설치 : [flutter 설치 가이드 링크](https://flutter.dev/docs/get-started/install)
2. 패키지 설치 :

   ```shell
   cd <프로젝트 폴더>
   flutter pub get
   ```

## Git hook 설정

- lefthook 설치
  - [lefthook 설치 가이드](https://github.com/Arkweid/lefthook/blob/master/docs/full_guide.md)
  - Windows 10은 [release](https://github.com/Arkweid/lefthook/releases)에서 다운 받은 후 환경변수에 지정
  - lefthook.yml 있는 폴더에서 `lefthook install` 실행
- lefthook-local.yml 파일 작성
  ```yml
  pre-push:
    exclude_tags:
      - backend
  pre-commit:
    exclude_tags:
      - backend
  ```
