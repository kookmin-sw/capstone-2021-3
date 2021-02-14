"""recycle_dataset dataset."""

import tensorflow_datasets as tfds
import recycle_dataset


class RecycleDatasetTest(tfds.testing.DatasetBuilderTestCase):
  """Tests for recycle_dataset dataset."""
  DATASET_CLASS = recycle_dataset.RecycleDataset
  # TODO(minho): Add checksum when data are released.
  SKIP_CHECKSUMS = True
  SPLITS = {
      'train': 8,
      'test': 8,
  }


if __name__ == '__main__':
  tfds.testing.test_main()
