# cardboardci/pdf2htmlex

cardboardci/pdf2htmlex is a Docker image built with continuous integration builds in mind. Each tag contains an pdf2htmlEX version and any binaries and tools that are required for builds to complete successfully in a continuous integration environment.

pdf2htmlEX renders PDF files in HTML, utilizing modern Web technologies. Academic papers with lots of formulas and figures? Magazines with complicated layouts? No problem!

Features:

* Native HTML text with precise font and location.
* Flexible output: all-in-one HTML or on demand page loading (needs JavaScript).
* Moderate file size, sometimes even smaller than PDF.
* Supporting links, outlines (bookmarks), printing, SVG background, Type 3 fonts and more.

You can see the cli reference [here](https://github.com/coolwanglu/pdf2htmlEX).

## Getting Started

This image can be used with the docker type for different types of continuous integration platforms. For example:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/pdf2htmlex:edge
              with:
                  args: "pdf2htmlex --version"
```

### Pull latest image

The edge or latest version of the image is available with the tag `edge`. This isn't intended to long term use, but for working with the latest version of the image. To pull the latest image, run the following:

```bash
docker pull ghcr.io/cardboardci/pdf2htmlex:edge
```

### Test interactively

Sometimes it can be useful to run the image in an interactive shell for experimentation. To shell into an image, run the following:

```bash
docker run -it ghcr.io/cardboardci/pdf2htmlex:edge /bin/bash
```

### Run basic AWS command

To run a single command from the context of the docker image, run the following:

```bash
docker run -it -v `pwd`:/workspace ghcr.io/cardboardci/pdf2htmlex:edge aws --version
```

## Fundamentals

All images in the CardboardCI namespace are built from cardboardci/base. This image is intended to provide a common set of dependencies and expectations about how the images will behave. The image will always be built from the base image, to ensure any changes seen in the base are included in the downstream image.
