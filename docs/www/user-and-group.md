# Understanding the User and Group

Docker images often are configured to run in the `root` user domain of an image. This kind of elevated access for processes inside the container is not necessary. The common scenario for these images is to run as command working off the contents of a mounted volume.

Continuous integration services will often make use of the `--user` flag to use a reduced permission level for clusters. When running locally, the `--user` flag may not always be specified. In these cases, the cardboardci user acts as a user with minimum permissions to work with the `/workspace` directory.

## Verify the user

```bash
docker run <image> cardboardi/base:edge id
```

## Labels

`docker inspect` to get the user

# Checking the user

If you are experiencing issues with one of our containers, it helps us to know which version of the image your container is running from. The primary reason we ask for this is because you may be reporting an issue we are aware of and have subsequently fixed. However, if you are running on the latest version of our image, it could indeed be a newly found bug, which we'd want to know more about.

To obtain the build version for the container:

```bash
docker inspect -f '{{ index .Config.Labels "build_version" }}' <container_name>
```

Or the image:

```bash
docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/<image_name>
```
