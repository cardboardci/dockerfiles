# cardboardci/gitlab

cardboardci/gitlab is a Docker image built with continuous integration builds in mind. Each tag contains any binaries and tools that are required for builds to complete successfully in a continuous integration environment. This includes `jq`, `curl`, `bash` and utilities for interacting with GitLab.

What is GitLabCLI ?

-   It's a cross platform GitLab command line tool to quickly & naturally perform frequent tasks on GitLab project.
-   It does not force you to hand craft json or use other unnatural ways (for example ids, concatenating of strings) like other CLI's to interact with GitLab.
-   It does not have any dependencies.
-   It's self contained .NET core application - you don't need to have .NET installed for it to work.

You can see the source repository [here](https://github.com/nmklotas/GitLabCLI).

## Getting Started

This image can be used with the docker type for different types of continuous integration platforms. For example:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/gitlab:edge
              with:
                  args: "lab --version"
```

### Pull latest image

The edge or latest version of the image is available with the tag `edge`. This isn't intended to long term use, but for working with the latest version of the image. To pull the latest image, run the following:

```bash
docker pull ghcr.io/cardboardci/gitlab:edge
```

### Test interactively

Sometimes it can be useful to run the image in an interactive shell for experimentation. To shell into an image, run the following:

```bash
docker run -it ghcr.io/cardboardci/gitlab:edge /bin/bash
```

### Run a basic command

To run a single command from the context of the docker image, run the following:

```bash
docker run -it -v `pwd`:/workspace ghcr.io/cardboardci/gitlab:edge aws --version
```

## Fundamentals

All images in the CardboardCI namespace are built from cardboardci/base. This image is intended to provide a common set of dependencies and expectations about how the images will behave. The image will always be built from the base image, to ensure any changes seen in the base are included in the downstream image.
