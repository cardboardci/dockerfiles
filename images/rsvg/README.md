# cardboardci/rsvg

cardboardci/rsvg is a Docker image built with continuous integration builds in mind. Each tag contains any binaries and tools that are required for builds to complete successfully in a continuous integration environment.

A utility to render Scalable Vector Graphics (SVG), associated with the GNOME Project. It renders SVG files to Cairo surfaces. Cairo is the 2D, antialiased drawing library that GNOME uses to draw things to the screen or to generate output for printing.

You can see the cli reference [here](https://github.com/GNOME/librsvg).

## Getting Started

This image can be used with the docker type for different types of continuous integration platforms. For example:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/rsvg:edge
              with:
                  args: "rsvg --version"
```

### Pull latest image

The edge or latest version of the image is available with the tag `edge`. This isn't intended to long term use, but for working with the latest version of the image. To pull the latest image, run the following:

```bash
docker pull ghcr.io/cardboardci/rsvg:edge
```

### Test interactively

Sometimes it can be useful to run the image in an interactive shell for experimentation. To shell into an image, run the following:

```bash
docker run -it ghcr.io/cardboardci/rsvg:edge /bin/bash
```

### Run basic AWS command

To run a single command from the context of the docker image, run the following:

```bash
docker run -it -v `pwd`:/workspace ghcr.io/cardboardci/rsvg:edge aws --version
```

## Fundamentals

All images in the CardboardCI namespace are built from cardboardci/base. This image is intended to provide a common set of dependencies and expectations about how the images will behave. The image will always be built from the base image, to ensure any changes seen in the base are included in the downstream image.
