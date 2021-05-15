"""
사용 예시: python data_augmentation.py --image_dir="path/to/image/directory" --sharpen --gaussian_blur --box_blur
"""
import os
from pathlib import Path

import cv2
from absl import app
from absl import flags

from augmentators.kernel import sharpen, box_blur, guassian_blur
from utils import glob_jpeg_alike


def save_augmented_img(agmt_method, img_path, out_dir, img):
  """
  path/to/img/dir/1/2021-04-29_21538497223.jpg 를
  augmented/1_sharpen/2021-04-29_21538497223_sharpen.jpg 처럼 바꿔서 저장.
  """
  # 해당 augmentation에 대한 폴더 없으면 만들어줌.
  agmt_out_dir = os.path.join(out_dir, img_path.parent.name + f"_{agmt_method}")
  Path(agmt_out_dir).mkdir(parents=True, exist_ok=True)

  new_filename = img_path.stem + f"_{agmt_method}" + img_path.suffix
  out_path = os.path.join(agmt_out_dir, new_filename)
  cv2.imwrite(out_path, img)


def main(_):
  image_dir = Path(flags.FLAGS.image_dir)
  if not image_dir.is_dir():
    print(f"No such directory {image_dir}")
    exit(1)

  out_dir = Path(flags.FLAGS.out_dir)
  out_dir.mkdir(parents=True, exist_ok=True)

  paths = glob_jpeg_alike(image_dir)

  for path in paths:
    img = cv2.imread(str(path))
    if flags.FLAGS.sharpen:
      sharpened_img = sharpen(img)
      save_augmented_img("sharpen", path, out_dir, sharpened_img)
    if flags.FLAGS.box_blur:
      blurred_img = box_blur(img)
      save_augmented_img("box_blurred", path, out_dir, blurred_img)
    if flags.FLAGS.gaussian_blur:
      blurred_img = guassian_blur(img)
      save_augmented_img("gaussian_blurred", path, out_dir, blurred_img)


if __name__ == "__main__":
  flags.DEFINE_string("image_dir", None, "이미지 폴더 경로")
  flags.DEFINE_string("out_dir", "augmented", "이미지 출력 디렉토리")
  flags.DEFINE_boolean("sharpen", False, "sharped filter 적용")
  flags.DEFINE_boolean("box_blur", False, "box blur filter 적용")
  flags.DEFINE_boolean("gaussian_blur", False, "gaussian blur filter 적용")
  flags.mark_flag_as_required('image_dir')
  app.run(main)
