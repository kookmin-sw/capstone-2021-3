# IOT 문서

- [IOT 문서](#iot-문서)
  - [설치](#설치)
  - [Topic 구조](#topic-구조)
  - [Client 실행](#client-실행)
  - [Publish](#publish)

## 설치

```
pip install -r .\requirements.txt
```

## Topic 구조

```
- device/
    - capacity/
        - plastic/:organization/:client_id # 플라스틱 적재량
        - water/:organization/:client_id # 물 적재량
    - point/:organization/:client_id # 포인트

예시)
국민대학교에 설치된 '1234' 아이디의 플라스틱 용량 구독
device/capacity/plastic/kookmin/1234
```

## Client 실행

```
# 필요한 내용들 변경 후 사용
cp example.env .env

# 서버 실행
uvicorn main:app
```

## Publish

- http://host:port/docs의 API문서 참고
