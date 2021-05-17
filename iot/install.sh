#!/bin/bash

# 패키지 업데이트 및 한글 폰트 설치
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y fonts-unfonts-core

# 프로젝트 초기화
git clone https://github.com/kookmin-sw/capstone-2021-3 ~/app
cd ~/app/iot

# 환경변수 설정
cp .env.example .env
nano .env

# 가상환경 실행
python3 -m venv venv
source venv/bin/activate

# 패키지 설치
pip3 install -r requirements.txt

# Systemd에 service 등록
sudo cp ./mqtt_client.service /etc/systemd/system/
sudo chmod 644 /etc/systemd/system/mqtt_client.service

# Unit 파일 소유자 & 권한 설정
sudo chown root:root /etc/systemd/system/mqtt_client.service
sudo chmod 644 /lib/systemd/system/mqtt_client.service

# Systemd 설정
sudo systemctl daemon-reload
sudo systemctl enable mqtt_client.service
sudo systemctl start mqtt_client.service
