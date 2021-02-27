# Common Base Image

cardboardci/base is an Ubuntu Docker image created with reproducibility in mind. This image serves as a base image for other CardboardCI images, supplying common dependencies and expected standards. This helps ensure that all images behave similar when chained together or executed in sequence.

Any image developed should use this as a base image to avoid unique image configurations that do not work as expected.

## Getting Started

This image is intended to be inherited by other images, either with a Dockerfile or through Bazel builds. The following is a Dockerfile example:

```dockerfile
FROM ghcr.io/cardboardci/base:20210211
USER root

RUN apt-get update && apt-get install -y ...
```

And the following is an example using Bazel:

```starlark
download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [ ... ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)
```

## How This Image Works

This image contains the Ubuntu Linux operating system and everything that is considered common among all of the images. This includes but is not limited to:

-   Bash
-   Curl
-   Git
-   SSH
-   jq

The full list can be seen in the `images/base` definition. All images are expected to have these configured and running in the environments.

## Tagging Scheme

This image has the following tagging scheme:

```
cardboardci/base:edge[-version]
cardboardci/base:<YYYYMMDD>[-version]
```

-   `edge` - This image tag points to the latest version of the Base image. This tag is built from the HEAD of the main branch. The edge tag is intended to be used as a reference version of the image before referencing by either tag or sha. This tag should not be used in continuous integration settings unless experimenting.
-   `<YYYYMMDD>` - This image tag is a build of the image, referred to by the 4 digit year, a 2 digit month, and the 2 digit day. For example 20210919 would be the build from September 19th 2021. This tag is intended for cases where image usages are frequently updated.
-   `-version` - This is an optional extension to the tag to specify variants of the image.
