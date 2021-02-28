# Tagging Scheme

The images in the organization have the following tagging scheme:

```
cardboardci/<name>:edge[-version]
cardboardci/<name>:<YYYYMMDD>[-version]
```

-   `edge` - This image tag points to the latest version of the image. This tag is built from the HEAD of the main branch. The edge tag is intended to be used as a reference version of the image before referencing by either tag or sha. This tag should not be used in continuous integration settings unless experimenting.
-   `<YYYYMMDD>` - This image tag is a build of the image, referred to by the 4 digit year, a 2 digit month, and the 2 digit day. For example 20210919 would be the build from September 19th 2021. This tag is intended for cases where image usages are frequently updated.
-   `-version` - This is an optional extension to the tag to specify variants of the image.

## Recommended Usages

The recommended usage is to use the SHA of the image with the tag included as a comment nearby. This uses the most precise version of the image, and includes a reference date for evaluating the age of the image itself.

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              # 20210227
              uses: docker://ghcr.io/cardboardci/base@sha256:e99aef505e9e3a5026a9a2873f2a5e3b029adb5c8f70327672f3a9a7aef2c73a
              with:
                  args: "echo hello"
```

If the image is frequently updated due to automation, then using just the tag is a valid usage.
