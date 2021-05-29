"""inobus_pet_v3 dataset."""
import itertools
from pathlib import Path

import tensorflow_datasets as tfds

# TODO(inobus_pet_v3): Markdown description  that will appear on the catalog page.
_DESCRIPTION = """
Shape: (224, 224, 3)
- train
    - yes_pet: inobus_v1_1(cropped) ~ inobus_v1_4(cropped) +  inobus_v2_4(cropped) ~ inobus_v2_26(cropped) + capstone_v1(cropped) 756장
    - no_pet: inobus_v1_5_PLA(cropped) + inobus_v1_6_PP(cropped) + capstone_v1_PP(cropped) 197장
- test
    - yes_pet: inobus_v2_1(cropped) + inobus_v2_2(cropped) + inobus_v2_3(cropped)  +
      inobus_v3_29(cropped) + inobus_v3_30(cropped) + inobus_v3_31(cropped) + inobus_v3_32(cropped) +
      inobus_v3_33(cropped) 160장
    - no_pet: inobus_v2_27_PP(cropped) + inobus_v2_28_PP(cropped) +
      inobus_v3_34_PP(cropped) + inobus_v3_35_PP(cropped) 80장
"""

# TODO(inobus_pet_v3): BibTeX citation
_CITATION = """
"""

# 로컬 inobus_pet_v3 경로.
_PATH = "/Users/minhoheo/Downloads/inobus_pet_v3"


class InobusPetV3(tfds.core.GeneratorBasedBuilder):
  """DatasetBuilder for inobus_pet_v3 dataset."""

  VERSION = tfds.core.Version('1.0.0')
  RELEASE_NOTES = {
      '1.0.0': 'Initial release.',
  }

  def _info(self) -> tfds.core.DatasetInfo:
    """Returns the dataset metadata."""
    return tfds.core.DatasetInfo(
        builder=self,
        description=_DESCRIPTION,
        features=tfds.features.FeaturesDict({
            # These are the features of your dataset like images, labels ...
            'image': tfds.features.Image(shape=(224, 224, 3)),
            'label': tfds.features.ClassLabel(names=['no_pet', 'yes_pet']),
        }),
        # If there's a common (input, target) tuple from the
        # features, specify them here. They'll be used if
        # `as_supervised=True` in `builder.as_dataset`.
        supervised_keys=('image', 'label'),  # Set to `None` to disable
        citation=_CITATION,
    )

  def _split_generators(self, dl_manager: tfds.download.DownloadManager):
    """Returns SplitGenerators."""
    path = Path(_PATH)

    return {
        'train': self._generate_examples(path / 'train'),
        'test': self._generate_examples(path / 'test')
    }

  def _generate_examples(self, path):
    """Yields examples."""
    # Yields (key, example) tuples from the dataset
    paths = itertools.chain((path.rglob('*.jpeg')), path.rglob('*.jpg'),
                            path.rglob('*.JPG'))
    for image_path in paths:
      key = image_path.parent.name + '/' + image_path.name
      yield key, {
          'image': image_path,
          'label': image_path.parent.name,
      }
