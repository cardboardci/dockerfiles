# cardboardci/luacheck

cardboardci/luacheck is a Docker image built with continuous integration builds in mind. Each tag contains any binaries and tools that are required for builds to complete successfully in a continuous integration environment. This includes `jq`, `curl`, `bash` and utilities for static analysis of Lua.

Luacheck is a static analyzer and a linter for Lua. Luacheck detects various issues such as usage of undefined global variables, unused variables and values, accessing uninitialized variables, unreachable code and more. Most aspects of checking are configurable: there are options for defining custom project-related globals, for selecting set of standard globals (version of Lua standard library), for filtering warnings by type and name of related variable, etc. The options can be used on the command line, put into a config or directly into checked files as Lua comments.

You can see the cli reference [here](https://github.com/mpeterv/luacheck).

## Getting Started

This image can be used with the docker type for different types of continuous integration platforms. For example:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/luacheck:edge
              with:
                  args: "luacheck --version"
```

### Pull latest image

The edge or latest version of the image is available with the tag `edge`. This isn't intended to long term use, but for working with the latest version of the image. To pull the latest image, run the following:

```bash
docker pull ghcr.io/cardboardci/luacheck:edge
```

### Test interactively

Sometimes it can be useful to run the image in an interactive shell for experimentation. To shell into an image, run the following:

```bash
docker run -it ghcr.io/cardboardci/luacheck:edge /bin/bash
```

### Run a basic command

To run a single command from the context of the docker image, run the following:

```bash
docker run -it -v `pwd`:/workspace ghcr.io/cardboardci/luacheck:edge luacheck --version
```

## Fundamentals

All images in the CardboardCI namespace are built from cardboardci/base. This image is intended to provide a common set of dependencies and expectations about how the images will behave. The image will always be built from the base image, to ensure any changes seen in the base are included in the downstream image.
