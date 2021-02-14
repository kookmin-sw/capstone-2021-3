"""recycle_dataset dataset."""
import itertools

import tensorflow_datasets as tfds

# TODO(minho): Markdown description  that will appear on the catalog page.
_DESCRIPTION = """
Description is **formatted** as markdown.

It should also contain any processing which has been applied (if any),
(e.g. corrupted example skipped, images cropped,...):
"""

# TODO(minho): BibTeX citation
_CITATION = """
"""

_URL = 'https://storage.googleapis.com/recycle_dataset/recycle_dataset.zip'


class RecycleDataset(tfds.core.GeneratorBasedBuilder):
  """DatasetBuilder for recycle_dataset dataset."""

  VERSION = tfds.core.Version('1.0.0')
  RELEASE_NOTES = {
      '1.0.0': 'Initial release.',
  }

  def _info(self) -> tfds.core.DatasetInfo:
    """Returns the dataset metadata."""
    # TODO(recycle_dataset): Specifies the tfds.core.DatasetInfo object
    return tfds.core.DatasetInfo(
        builder=self,
        description=_DESCRIPTION,
        features=tfds.features.FeaturesDict({
            # These are the features of your dataset like images, labels ...
            'image':
                tfds.features.Image(shape=(None, None, 3)),
            'label':
                tfds.features.ClassLabel(names=[
                    'can', 'carton', 'glass', 'paper', 'pet', 'plastic',
                    'styrofoam', 'vinyl'
                ]),
        }),
        # If there's a common (input, target) tuple from the
        # features, specify them here. They'll be used if
        # `as_supervised=True` in `builder.as_dataset`.
        supervised_keys=('image', 'label'),  # Set to `None` to disable
        citation=_CITATION,
    )

  def _split_generators(self, dl_manager: tfds.download.DownloadManager):
    """Returns SplitGenerators."""
    # Downloads the data and defines the splits
    path = dl_manager.download_and_extract(_URL)

    # Returns the Dict[split names, Iterator[Key, Example]]
    return {
        'train': self._generate_examples(path / 'recycle_dataset' / 'train'),
        'test': self._generate_examples(path / 'recycle_dataset' / 'test')
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
