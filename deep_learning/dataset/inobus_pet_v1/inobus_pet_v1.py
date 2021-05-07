"""inobus_pet_v1 dataset."""
import itertools
from pathlib import Path

import tensorflow_datasets as tfds

# TODO(inobus_pet_v1): Markdown description  that will appear on the catalog page.
_DESCRIPTION = """
Shape: (224, 224, 3)
- train
    - yes_pet: 1.pet + 3.pet(pete): 592장
    - no_pet: 5.pla: 438장
- test
    - yes_pet: 2.pet + 4.pet(pete): 572장
    - no_pet: 6.pp: 360장
"""

# TODO(inobus_pet_v1): BibTeX citation
_CITATION = """
"""

# 로컬 inobus_pet_v1 경로.
_PATH = ""


class InobusPetV1(tfds.core.GeneratorBasedBuilder):
  """DatasetBuilder for inobus_pet_v1 dataset."""

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
    paths = itertools.chain((path.rglob('*.jpeg')), path.rglob('*.jpg'))
    for image_path in paths:
      key = image_path.parent.name + '/' + image_path.name
      yield key, {
          'image': image_path,
          'label': image_path.parent.name,
      }
