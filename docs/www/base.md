# cardboardci/base

cardboardci/base is an Ubuntu Docker image created with reproducability in mind. This image serves as a base image for other CardboardCI images. The image is intended to supply all common dependencies for continuous integration images.

This image should be used as a base image for all CardboardCI images to avoid unique image configurations that do not work as expected.

# Getting Started

This image can be used with the docker type for different types of continuous integration platforms. For example:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/base:20210211
```

In the above example, the CircleCI Base Docker image is used for the primary container. More specifically, the tag 2021.02 indicates the dated version of the base image. See how tags work below for more information.

# How This Image Works

This image contains the Ubuntu Linux operating system and everything that is considered common among all of the images. This includes but is not limited to:

-   Bash
-   Curl
-   Git
-   SSH
-   jq

The full list can be seen in the `images/base` definition.

# Tagging Scheme

This image has the following tagging scheme:

```
cardboardci/base:edge[-version]
cardboardci/base:<YYYY.MM>[-version]
```

edge - This image tag points to the latest version of the Base image. This tag is built from the HEAD of the master branch. The edge tag is intended to be used as a testing version of the image with the most recent changes however not guaranteed to be all that stable. This tag is not recommended for production software.

stable - This image tag points to the latest, production ready base image. This image should be used by projects that want a decent level of stability but would like to get occasional software updates. It is typically updated once a month.

<YYYY.MM> - This image tag is a monthly snapshot of the image, referred to by the 4 digit year, dot, and a 2 digit month. For example 2019.09 would be the monthly snapshot tag from September 2019. This tag is intended for projects that are highly sensitive to changes and want the most deterministic builds possible.

-version - This is an optional extension to the tag to specify the version of Ubuntu to use. There can be up to two options, the current LTS and the previous LTS. As of this writing, those options would be 18.04 or 20.04. When leaving the version out, suggested, the default version will be used. The default Ubuntu version is the newest LTS version, after it has been out for 2 months. For example, Ubuntu 20.04 came out in April 2020, so it became the default version for this image in June 2020. The previous LTS version will be supported for a year after it drops out of the default slot.
