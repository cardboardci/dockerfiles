# cardboardci/stylelint

cardboardci/stylelint is a Docker image built with continuous integration builds in mind. Each tag contains any binaries and tools that are required for builds to complete successfully in a continuous integration environment. This includes `jq`, `curl`, `bash` and utilities for linting modern web files.

A mighty, modern linter that helps you avoid errors and enforce conventions in your styles.

It's mighty because it:

-   understands the latest CSS syntax including custom properties and level 4 selectors
-   extracts embedded styles from HTML, markdown and CSS-in-JS object & template literals
-   parses CSS-like syntaxes like SCSS, Sass, Less and SugarSS
-   has over 170 built-in rules to catch errors, apply limits and enforce stylistic conventions
-   supports plugins so you can create your own rules or make use of plugins written by the community
-   automatically fixes some violations (experimental feature)
-   is well tested with over 10000 unit tests
-   supports shareable configs that you can extend or create your own of
-   is unopinionated so you can tailor the linter to your exact needs

You can see the cli reference [here](https://github.com/stylelint/stylelint).

## Getting Started

This image can be used with the docker type for different types of continuous integration platforms. For example:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/stylelint:edge
              with:
                  args: "stylelint --version"
```

### Pull latest image

The edge or latest version of the image is available with the tag `edge`. This isn't intended to long term use, but for working with the latest version of the image. To pull the latest image, run the following:

```bash
docker pull ghcr.io/cardboardci/stylelint:edge
```

### Test interactively

Sometimes it can be useful to run the image in an interactive shell for experimentation. To shell into an image, run the following:

```bash
docker run -it ghcr.io/cardboardci/stylelint:edge /bin/bash
```

### Run a basic command

To run a single command from the context of the docker image, run the following:

```bash
docker run -it -v `pwd`:/workspace ghcr.io/cardboardci/stylelint:edge stylelint --version
```

## Fundamentals

All images in the CardboardCI namespace are built from cardboardci/base. This image is intended to provide a common set of dependencies and expectations about how the images will behave. The image will always be built from the base image, to ensure any changes seen in the base are included in the downstream image.
