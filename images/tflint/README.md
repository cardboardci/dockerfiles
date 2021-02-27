# cardboardci/tflint

cardboardci/tflint is a Docker image built with continuous integration builds in mind. Each tag contains any binaries and tools that are required for builds to complete successfully in a continuous integration environment. This includes `jq`, `curl`, `bash` and utilities for static analysis of Terraform.

TFLint is a Terraform linter focused on possible errors, best practices, etc.

You can see the cli reference [here](https://github.com/terraform-linters/tflint).

## Getting Started

This image can be used with the docker type for different types of continuous integration platforms. For example:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/tflint:edge
              with:
                  args: "awscli --version"
```

### Pull latest image

The edge or latest version of the image is available with the tag `edge`. This isn't intended to long term use, but for working with the latest version of the image. To pull the latest image, run the following:

```bash
docker pull ghcr.io/cardboardci/tflint:edge
```

### Test interactively

Sometimes it can be useful to run the image in an interactive shell for experimentation. To shell into an image, run the following:

```bash
docker run -it ghcr.io/cardboardci/tflint:edge /bin/bash
```

### Run a basic command

To run a single command from the context of the docker image, run the following:

```bash
docker run -it -v `pwd`:/workspace ghcr.io/cardboardci/tflint:edge aws --version
```

## Fundamentals

All images in the CardboardCI namespace are built from cardboardci/base. This image is intended to provide a common set of dependencies and expectations about how the images will behave. The image will always be built from the base image, to ensure any changes seen in the base are included in the downstream image.
