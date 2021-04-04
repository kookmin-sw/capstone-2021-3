## Deep Learning 환경설정
Python 3.8 Virtual Environments 설정
`pip install -r requirements.txt` 실행

```shell
# Example
python3 -m venv <venv_name>
source <venv_path>/bin/activate
pip3 install -r requirements.txt
```

## 데이터 준비 (Internal)
  - Cloud Storage에서 데이터 다운로드 후, `_PATH` 변수를 다운로드 받은 데이터 경로로 지정
  - 데이터 셋 폴더에서 `tfds build` 실행
  - "data_example.ipynb" 으로 데이터 사용예제 확인

```shell
# Example
cd recycle_dataset/
tfds build # 데이터 다운로드, 준비
jupyter lab # 예제 노트북 확인
```
