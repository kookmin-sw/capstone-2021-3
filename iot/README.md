# IOT 문서

- [IOT 문서](#iot-문서)
  - [설치](#설치)
  - [Topic 구조](#topic-구조)
  - [Client 실행](#client-실행)
  - [데이터 수집](#데이터-수집)

## 설치

```
pip install -r .\requirements.txt
```

## Topic 구조

```
:organization_id - 기관에 부여되는 아이디
:device_id - 기기에 부여되는 아이디

- device/
    - capacity/
        - plastic/:organization_id/:device_id # 플라스틱 적재량
        - water/:organization_id/:device_id # 물 적재량
    - point/:organization_id/:device_id # 포인트

예시)
국민대학교에 설치된 'kookmin_device'의 플라스틱 용량 구독
device/capacity/plastic/kookmin_id/kookmin_device_id
```

## Client 실행

1. 환경 변수 설정

   ```
   # 필요한 내용들 변경 후 사용
   cp .env.example .env
   ```

2. 서버 실행

   ```
   # 서버 실행
   uvicorn main:app --env-file .env.example
   ```

3. 설정
   - http://localhost:8000/admin 으로 접속후 setting 진행

## 데이터 수집

- http://localhost:8000/docs의 API문서 참고
