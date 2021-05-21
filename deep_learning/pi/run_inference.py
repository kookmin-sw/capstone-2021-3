import argparse
import os
import time
from pathlib import Path

import tflite_runtime.interpreter as tflite
import cv2
import numpy as np


def read_input_images(data_path):
  img_files = data_path.rglob('*.jpg')
  imgs = [cv2.imread(str(img_file)) for img_file in img_files]
  imgs = [cv2.cvtColor(img, cv2.COLOR_BGR2RGB) for img in imgs]

  return imgs


def main():
  parser = argparse.ArgumentParser()
  parser.add_argument('-m', '--model_file', help="path to tflite model file")
  parser.add_argument('-d',
                      '--data_path',
                      help="path to dataset to run inference")
  args = parser.parse_args()

  interpreter = tflite.Interpreter(model_path=args.model_file)
  interpreter.allocate_tensors()

  input_details = interpreter.get_input_details()
  output_details = interpreter.get_output_details()
  input_shape = input_details[0]['shape']

  images = read_input_images(Path(args.data_path))

  count = 0
  time_accum = 0
  for image in images:
    input_data = np.expand_dims(image, axis=0)
    input_data = np.float32(input_data)

    interpreter.set_tensor(input_details[0]['index'], input_data)
    start_time = time.time()
    interpreter.invoke()
    stop_time = time.time()

    interval = stop_time - start_time
    time_accum += interval

    print('Inference time: {:.3f}ms'.format(interval * 1000))

    prediction = interpreter.get_tensor(output_details[0]['index'])
    print(f'Prediction: {prediction[0]}')
    count += 1

  print('Inference time on average: {:.3f}ms'.format(
      (time_accum / count) * 1000))


if __name__ == "__main__":
  main()
