import io
import time

import cv2
import numpy as np
import pygame
import requests
import RPi.GPIO as GPIO
import tflite_runtime.interpreter as tflite
from picamera import PiCamera

pygame.mixer.init()
Audio1 = pygame.mixer.Sound("/home/pi/01_start.wav")
Audio2 = pygame.mixer.Sound("/home/pi/02_done.wav")

camera = PiCamera()

IMG_SIZE = 448
THRESHOLD = 0.5
MODEL_PATH = '/home/pi/mobilenet_448_3.tflite'

interpreter = tflite.Interpreter(model_path=MODEL_PATH)
interpreter.allocate_tensors()

input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

button = 40
# LED = 38
out1 = 13
out2 = 11
out3 = 15
out4 = 12
out5 = 16
out6 = 18
SolValve = 7
PUL = 37
DIR = 35
ENA = 33
Trig = 29
Echo = 31
Trig2 = 36
Echo2 = 38

GPIO.setmode(GPIO.BOARD)

GPIO.setup(button, GPIO.IN, pull_up_down=GPIO.PUD_UP)
# GPIO.setup(LED, GPIO.OUT)
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

GPIO.output(out5, GPIO.LOW)
GPIO.output(out6, GPIO.LOW)
GPIO.output(ENA, GPIO.HIGH)
GPIO.setup(Trig, GPIO.OUT)
GPIO.setup(Echo, GPIO.IN)
GPIO.setup(Trig2, GPIO.OUT)
GPIO.setup(Echo2, GPIO.IN)


def LinearMotor(direction):
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


def Camera():
    stream = io.BytesIO()

    print("Camera resolution: {}".format(camera.resolution))
    camera.start_preview()
    time.sleep(2)
    camera.capture('/home/pi/img_log/{}.jpeg'.format(time.time()))
    camera.capture(stream, format='jpeg', resize=(IMG_SIZE, IMG_SIZE))
    print("Image captured!")

    data = np.fromstring(stream.getvalue(), dtype=np.uint8)
    img = cv2.imdecode(data, 1)
    # Return RGB image.

    camera.stop_preview()
    return img[:, :, ::-1]


def forward(durationFwd, delay):
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


def reverse(durationBwd, delay):
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


def sonic():
    GPIO.output(Trig, False)
    time.sleep(0.5)

    GPIO.output(Trig, True)
    time.sleep(0.00001)
    GPIO.output(Trig, False)

    while GPIO.input(Echo) == 0:
        start = time.time()

    while GPIO.input(Echo) == 1:
        stop = time.time()

    timeInterval = stop - start
    distance = timeInterval * 17000
    distance = round(distance, 2)

    return distance


def sonic2():
    GPIO.output(Trig2, False)
    time.sleep(0.5)

    GPIO.output(Trig2, True)
    time.sleep(0.00001)
    GPIO.output(Trig2, False)

    while GPIO.input(Echo2) == 0:
        start = time.time()

    while GPIO.input(Echo2) == 1:
        stop = time.time()

    timeInterval = stop - start
    distance = timeInterval * 17000
    distance = round(distance, 2)

    return distance


#########################################

try:
    while 1:
        if GPIO.input(button) == 0:
            # GPIO.output(LED, False)
            print("Start Operation")

            requests.post("http://localhost:8000/point")
            print("Notice point for organization")

            Audio1.play()
            print("Audio1 play")
            time.sleep(0.3)

            LinearMotor(0)
            time.sleep(0.3)

            GPIO.output(SolValve, True)
            print("SolValve On")
            time.sleep(1.5)

            GPIO.output(SolValve, False)
            print("SolValve Off")
            time.sleep(1)

            LinearMotor(1)

            img = Camera()
            interpreter.set_tensor(input_details[0]['index'],
                                   np.expand_dims(img.astype(np.float32), axis=0))
            interpreter.invoke()
            prediction = interpreter.get_tensor(output_details[0]['index'])[0]

            if prediction >= THRESHOLD:
                forward(700, 0.0015)
                reverse(700, 0.0015)
            else:
                reverse(700, 0.0015)
                forward(700, 0.0015)

            Audio2.play()

            distance = sonic()
            distance2 = sonic2()
            print("Distance: ", distance, "cm")
            print("Distance2: ", distance2, "cm")
            time.sleep(3)

        else:
            print("0")
            # GPIO.output(LED, True)

finally:
    GPIO.cleanup()
