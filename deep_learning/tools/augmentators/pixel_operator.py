""" Pixel operator 적용

관련 내용:  https://docs.opencv.org/3.4/d3/dc1/tutorial_basic_linear_transform.html
"""
import cv2
import numpy as np


def contrast(img):
  alpha = 1.2
  return cv2.convertScaleAbs(img, alpha=alpha, beta=0.)


def brighten(img):
  beta = 30 
  return cv2.convertScaleAbs(img, alpha=1.0, beta=beta)
