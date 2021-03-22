"""툴에 필요한 유틸리티 함수"""
import itertools


def glob_jpeg_alike(dir_path):
  """주어진 디렉토리에 있는 jpeg, JPG, jpg 파일들의 경로를 반환. 폴더를 재귀적으로 탐색하지 않음."""
  return itertools.chain((dir_path.glob("*.jpeg")), dir_path.glob("*.jpg"),
                         dir_path.glob("*.JPG"))


def rglob_jpeg_alike(dir_path):
  """주어진 디렉토리에 있는 jpeg, JPG, jpg 파일들의 경로를 반환. 폴더를 재귀적으로 탐색함."""
  return itertools.chain((dir_path.rglob("*.jpeg")), dir_path.rglob("*.jpg"),
                         dir_path.rglob("*.JPG"))
