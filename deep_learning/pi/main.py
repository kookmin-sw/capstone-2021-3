import time

import io
import cv2
import numpy as np
import RPi.GPIO as GPIO
import pygame  #오디오 라이브러리
from picamera import PiCamera  #카메라 라이브러리
import tflite_runtime.interpreter as tflite

pygame.mixer.init()  #오디오 설정
Audio1 = pygame.mixer.Sound("/home/pi/01_start.wav")
Audio2 = pygame.mixer.Sound("/home/pi/02_done.wav")

IMG_SIZE = 448
THRESHOLD = 0.5
MODEL_PATH = '/home/pi/mobilenet_448_3.tflite'

interpreter = tflite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

button = 40  #버튼 핀
LED = 38  #버튼 LED 핀
out1 = 13  #리니어 모터
out2 = 11  #리니어 모터
out3 = 15  #리니어 모터
out4 = 12  #리니어 모터
out5 = 16  #리니어 모터
out6 = 18  #리니어 모터
SolValve = 7  #솔레노이드 밸브 핀
PUL = 37  #스피너 모터
DIR = 35  #스피너 모터
ENA = 33  #스피너 모터
GPIO.setmode(GPIO.BOARD)  #보드 핀 번호 사용

GPIO.setup(button, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(LED, GPIO.OUT)
GPIO.setup(out1, GPIO.OUT)
GPIO.setup(out2, GPIO.OUT)
GPIO.setup(out3, GPIO.OUT)
GPIO.setup(out4, GPIO.OUT)
GPIO.setup(out5, GPIO.OUT)
GPIO.setup(out6, GPIO.OUT)
GPIO.setup(SolValve, GPIO.OUT)
GPIO.setup(PUL, GPIO.OUT)
GPIO.setup(DIR, GPIO.OUT)
GPIO.setup(ENA, GPIO.OUT)

GPIO.output(out5, GPIO.LOW)  #리니어 모터 꺼진채로 시작
GPIO.output(out6, GPIO.LOW)  #리니어 모터 꺼진채로 시작
GPIO.output(ENA, GPIO.HIGH)  #스피너 모터 "켜"진채로 시작->컵을 잡아줘야 돼서 항상 전류를 흘려줘야함.


def LinearMotor(
    direction
):  # 리니어모터 함수 => 입력값 directionn: 1=UP(노즐 위로 올라감) / 0=DOWN(노즐 아래로 내려감)

  i = 0
  positive = 0
  negative = 0
  y = 0
  GPIO.output(out1, GPIO.LOW)
  GPIO.output(out2, GPIO.LOW)
  GPIO.output(out3, GPIO.LOW)
  GPIO.output(out4, GPIO.LOW)
  GPIO.output(out5, GPIO.HIGH)
  GPIO.output(out6, GPIO.HIGH)
  # CW
  if direction == 1:
    print("Linear Step Motor UP...")
    for y in range(3000, 0, -1):
      if negative == 1:
        if i == 7:
          i = 0
        else:
          i = i + 1
        y = y + 2
        negative = 0
      positive = 1
      # print((x+1)-y)
      if i == 0:
        GPIO.output(out1, GPIO.HIGH)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 1:
        GPIO.output(out1, GPIO.HIGH)
        GPIO.output(out2, GPIO.HIGH)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 2:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.HIGH)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 3:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.HIGH)
        GPIO.output(out3, GPIO.HIGH)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 4:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.HIGH)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 5:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.HIGH)
        GPIO.output(out4, GPIO.HIGH)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 6:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.HIGH)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 7:
        GPIO.output(out1, GPIO.HIGH)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.HIGH)
        time.sleep(0.001)
        # time.sleep(1)
      if i == 7:
        i = 0
        continue
      i = i + 1
    GPIO.output(out5, GPIO.LOW)
    GPIO.output(out6, GPIO.LOW)
  # CCW
  elif direction == 0:
    print("Linear Step Motor DOWN...")
    for y in range(3000, 0, -1):
      if positive == 1:
        if i == 0:
          i = 7
        else:
          i = i - 1
        y = y + 3
        positive = 0
      negative = 1
      # print((x+1)-y)
      if i == 0:
        GPIO.output(out1, GPIO.HIGH)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 1:
        GPIO.output(out1, GPIO.HIGH)
        GPIO.output(out2, GPIO.HIGH)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 2:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.HIGH)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 3:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.HIGH)
        GPIO.output(out3, GPIO.HIGH)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 4:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.HIGH)
        GPIO.output(out4, GPIO.LOW)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 5:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.HIGH)
        GPIO.output(out4, GPIO.HIGH)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 6:
        GPIO.output(out1, GPIO.LOW)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.HIGH)
        time.sleep(0.001)
        # time.sleep(1)
      elif i == 7:
        GPIO.output(out1, GPIO.HIGH)
        GPIO.output(out2, GPIO.LOW)
        GPIO.output(out3, GPIO.LOW)
        GPIO.output(out4, GPIO.HIGH)
        time.sleep(0.001)
        # time.sleep(1)
      if i == 0:
        i = 7
        continue
      i = i - 1
    GPIO.output(out5, GPIO.LOW)
    GPIO.output(out6, GPIO.LOW)


def read_from_camera():  # 카메라 함수
  stream = io.BytesIO()
  with PiCamera as camera:
    print("Camera resolution: {}".format(camera.resolution))
    camera.start_preview()
    time.sleep(2)
    camera.capture(stream, format='jpeg', resize=(IMG_SIZE, IMG_SIZE))
    print("Image captured!")

    data = np.fromstring(stream.getvalue(), dtype=np.float32)
    img = cv2.imdecode(data, 1)
    # Return RGB image.
    
    # 이미지 저장.
    cv2.imwrite('img_log/{}.jpeg'.format(time.time()))
    return img[:, :, ::-1]


def forward(
    durationFwd,
    delay):  #스피너 모터 (앞으로 회전) 함수 => 입력값 durationFwd:얼마나 돌릴지 / delay: 속도(작을수록 빠름)
  # GPIO.output(ENA, GPIO.HIGH)
  print('Spinner Forward...')

  time.sleep(.5)
  GPIO.output(DIR, GPIO.LOW)

  for x in range(durationFwd):
    GPIO.output(PUL, GPIO.HIGH)
    time.sleep(delay)
    GPIO.output(PUL, GPIO.LOW)
    time.sleep(delay)
  # GPIO.output(ENA, GPIO.LOW)
  time.sleep(.5)
  return


def reverse(durationBwd,
            delay):  #스피너 모터 (뒤로 회전) 함수 => 입력값 durationBwd:얼마나 돌릴지 / delay: 속도
  # GPIO.output(ENA, GPIO.HIGH)
  print('Spinner Backward...')

  time.sleep(.5)
  GPIO.output(DIR, GPIO.HIGH)

  for y in range(durationBwd):
    GPIO.output(PUL, GPIO.HIGH)
    time.sleep(delay)
    GPIO.output(PUL, GPIO.LOW)
    time.sleep(delay)
  # GPIO.output(ENA, GPIO.LOW)
  time.sleep(.5)
  return


def main():
  while True:
    if GPIO.input(button) == 0:  #버튼이 눌리면
      GPIO.output(LED, False)
      print("Start Operation")  #작동시작

      Audio1.play()  #오디오 재생(세척을 시작합니다.)
      print("Audio1 play")
      time.sleep(0.3)

      LinearMotor(0)  # DOWN(노즐 아래로 내려감)
      time.sleep(0.3)

      GPIO.output(SolValve, True)  #솔레노이드 밸브 ON
      print("SolValve On")
      time.sleep(1.5)  # 2초간 대기 (세척중)

      GPIO.output(SolValve, False)  #솔레노이드 밸브 OFF
      print("SolValve Off")  ## 세척 완료
      time.sleep(1)

      LinearMotor(1)  # UP(노즐 위로 올라감)

      #이제 여기서 딥러닝 모델 돌린다음~ 출력값을 Output으로 받아서~(예를 들어 PET면 1 아니면 0)
      img = read_from_camera()  # 사진촬영
      interpreter.set_tensor(input_details[0]['index'],
                             np.expand_dims(img, axis=0))
      interpreter.invoke()
      prediction = interpreter.get_tensor(output_details[0]['index'])[0]

      if prediction > THRESHOLD:  #PET면
        forward(800, 0.001)  #앞으로 180도 회전
      else:  #아니면
        reverse(800, 0.001)  #뒤로 180도 회전

      Audio2.play()  #오디오 재생(세척이 완료되었습니다. 감사합니다.)
      time.sleep(3)

    else:  #버튼이 안눌리면
      print("0")
      GPIO.output(LED, True)


if __name__ == '__main__':
  main()
