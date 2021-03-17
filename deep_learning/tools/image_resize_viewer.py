"""이미지 디렉토리, 원하는 이미지 사이즈를 입력값으로 주면 resize된 이미지들을 보여주는 툴.

이미지 resize하면 PET 글씨가 너무 작아져서 안보일까 테스트 할때 씀.
사용 예제:
python tools/image_resize_viewer.py --image_dir="path/to/image/dir" --image_size=224
"""
from pathlib import Path
import itertools

import matplotlib.pyplot as plt
from PIL import Image
from absl import app
from absl import flags


def handle_close(_):
  global closed
  closed = True


fig = plt.figure()
closed = False
fig.canvas.mpl_connect("close_event", handle_close)


def imshow_wait_input(img):
  """키보드 입력, 마우스클릭 기다리는 imshow"""
  plt.imshow(img)
  plt.draw()
  plt.waitforbuttonpress(0)


def main(_):
  dir_path = Path(flags.FLAGS.image_dir)
  if not dir_path.is_dir():
    print(f"No such directory {dir_path}")
    exit(1)

  new_size = (flags.FLAGS.image_size, flags.FLAGS.image_size)
  # jpg, jpeg 이미지들만 보여줌. png등 다른포멧은 지원안함.
  paths = itertools.chain((dir_path.rglob("*.jpeg")), dir_path.rglob("*.jpg"))
  for path in paths:
    with Image.open(path) as img
      imshow_wait_input(img.resize(new_size))

    if closed:
      break


if __name__ == "__main__":
  flags.DEFINE_string("image_dir", None, "이미지 폴더 경로")
  flags.DEFINE_integer("image_size", None, "원하는 이미지 사이즈")
  app.run(main)
