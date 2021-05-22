# IOT 문서

- [IOT 문서](#iot-문서)
  - [설치](#설치)
  - [Topic 구조](#topic-구조)
  - [개발](#개발)
  - [데이터 수집](#데이터-수집)

## 설치

아래 명령어를 raspberry pi의 터미널에서 실행한 후 [개발](#개발) 섹션의 설정을 진행해주세요.

```shell
wget -qO- https://raw.githubusercontent.com/kookmin-sw/capstone-2021-3/master/iot/install.sh | sh
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

## 개발

1. 패키지 설치

   ```
   pip install -r .\requirements.txt
   ```

2. 환경 변수 설정

   ```
   # 필요한 내용들 변경 후 사용
   cp .env.example .env
   ```

3. 서버 실행

   ```
   # 서버 실행
   uvicorn main:app --env-file .env
   ```

4. 설정
   - http://localhost:8000/admin 으로 접속후 setting 진행

## 데이터 수집

- http://localhost:8000/docs 의 API문서 참고
