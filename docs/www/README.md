# CardboardCI

A collection of docker images that provide a common core for use in continuous integration.

The idea of these images is to balance the following:

- Frequency of updates
- Standard set of tooling
- Common Environment

## Status

Project is still is progress, documentation is lacking, progress will evolve over time. Aims as below:

- Dependencies are pinned
- Dependencies are updated automatically by GitHub Actions
- Images have basic documentation for common usages (GitHub Actions / etc)
- Tests verifying aspects of each image (/tmp empty, metadata set)