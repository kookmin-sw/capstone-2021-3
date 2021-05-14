"""Kernel을 이용한 image processing 함수들

관련 내용: https://en.wikipedia.org/wiki/Kernel_(image_processing)
"""
import cv2
import numpy as np


def sharpen(img):
  kernel = np.array([[0, -1., 0], [-1, 5, -1], [0, -1, 0]], dtype=np.float32)
  sharpened_img = cv2.filter2D(img, -1, kernel)
  return sharpened_img


def box_blur(img):
  kernel = np.ones((7, 7)) / 49.
  blurred_img = cv2.filter2D(img, -1, kernel)
  return blurred_img


def guassian_blur(img):
  kernel = np.array([[1, 4, 6, 4, 1], [4, 16, 24, 16, 4], [6, 24, 36, 24, 6],
                     [4, 16, 24, 16, 4], [1, 4, 6, 4, 1]]) / 256.
  blurred_img = cv2.filter2D(img, -1, kernel)
  return blurred_img
