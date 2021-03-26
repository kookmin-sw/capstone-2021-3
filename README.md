# 분리배출의 민족

팀페이지 주소 : https://kookmin-sw.github.io/capstone-2021-3/

- [분리배출의 민족](#분리배출의-민족)
  - [1. 프로젝트 소개](#1-프로젝트-소개)
  - [2. 소개](#2-소개)
    - [애플리케이션 기능 소개](#애플리케이션-기능-소개)
  - [3. 팀 소개](#3-팀-소개)
  - [4. 사용법](#4-사용법)
  - [5. 개발](#5-개발)
    - [협업 규칙](#협업-규칙)
      - [브랜치 명명 규칙](#브랜치-명명-규칙)
      - [Pull request 명명 규칙](#pull-request-명명-규칙)
      - [Commit 규칙](#commit-규칙)
    - [Application 문서](#application-문서)
    - [Backend 문서](#backend-문서)
    - [API 문서](#api-문서)
    - [Deep Learning 환경 설정](#deep-learning-환경-설정)

## 1. 프로젝트 소개

**폐플라스틱 선순환 생태계 조성 프로젝트**

[Inobus 의 쓰샘](https://www.inobus.co.kr/story)은 '환경부 분리배출 4대 원칙 (비운다, 헹군다, 분리한다, 분류한다)`을 준수한 플라스틱 컵 수거함이다. 위에서 언급한 4대 원칙이 지켜지지 않는다면 재가공하기 어렵기 때문에 현재 일회용 플라스틱의 단 5%만이 재활용되고 있다. 이를 해결하기 위해 쓰샘은 한 자리에서 간편하게 4가지 방법을 모두 지킬 수 있는 환경을 제공해준다.

하지만 이렇게 깨끗하게 세척된 컵들을 모은다고 하더라고 같은 재질별로 분류를 해야만 제대로 재활용을 할 수 있다. 이런 이유 때문에 현재는 수거된 플라스틱 컵들을 분류하기 위한 인력이 따로 필요한 상황이다.

이번 캡스톤 프로젝트에서는 위의 문제를 해결하기 위한 컵 재질 선별기와 딥러닝 모델 개발한다.

또한 컵 수거함을 이용하는 시민들의 참여를 독려할 리워딩(기부 또는 재활용 제품, 텀블러 등) 시스템과 서비스 이용을 편리하게 해줄 애플리케이션 또한 함께 개발을 진행한다.

## 2. 소개

### 애플리케이션 기능 소개

## 3. 팀 소개

```

허태정

Student ID : 20181708
E-Mail : gjdigj145@kookmin.ac.kr
Role : 팀장, 백엔드, 애플리케이션 (보조)
Github : [@Aqudi](https://github.com/Aqudi)

```

```

동설아

Student ID : 20171618
E-Mail : dsawt98@kookmin.ac.kr
Role : 애플리케이션
Github : [@TongSeola](https://github.com/TongSeola)

```

```

박정섭

Student ID : 20181616
E-Mail : parkjeongseop@kookmin.ac.kr
Role : 백엔드
Github : [@ParkJeongseop](https://github.com/ParkJeongseop)

```

```

허민호

Student ID : 20143115
E-Mail : gjalsgh1234@kookmin.ac.kr
Role : 딥러닝 모델 개발
Github : [@minoring](https://github.com/minoring)

```

## 4. 사용법

## 5. 개발

### 협업 규칙

#### 브랜치 명명 규칙

- kebab-case 사용

#### Pull request 명명 규칙

- 아래의 Commit 규칙과 동일하게 사용

#### Commit 규칙

- Prefix 사용
  - 추가: 파일추가
  - 구현: 기능 구현 및 개선
  - 버그: 버그 고치기
  - 문서: 문서작업
  - 포멧: 컨벤션 맞추기 등
  - 리팩터: 리팩토링할 때 사용
- 관련된 이슈가 있을 경우 Issue 링크 걸기
- Commit message 예시)

  ```
  구현: MongoDB 연동

  - 로컬에 DB서버를 구축하여 개발 진행
  - Device모델의 일부 항목 타입 변경

  Issue #41, #36
  ```

### [Application 문서](app/)

### [Backend 문서](backend/)

### [API 문서](backend/docs.html)

### Deep Learning 환경 설정

- Python 3.8 Virtual Environments 설정
- "deep_learning/" 폴더에서 `pip install -r requirements.txt` 실행

```shell
# Example
cd deep_learning
python3 -m venv <venv_name>
source <venv_path>/bin/activate
pip3 install -r requirements.txt
```

- #### 데이터 준비 (Internal)
  - Cloud Storage에서 데이터 다운로드 후, recycle_dataset.py의 `_PATH` 변수를 다운로드 받은 데이터 경로로 지정
  - "deep_learning/recycle_dataset/" 폴더에서 `tfds build` 실행
  - `python recycle_dataset_test.py` 실행으로 데이터 테스트
  - "data_example.ipynb" 으로 데이터 사용예제 확인

```shell
# Example
cd deep_learning/recycle_dataset/
tfds build # 데이터 다운로드, 준비
jupyter lab # 예제 노트북 확인
```
