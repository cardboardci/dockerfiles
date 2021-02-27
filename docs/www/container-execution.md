# Container Execution

You may find at some point you need to locally run the container or view the internal contents of the container.

# Shell Access

Particularly useful when you wish to work in a docker environment - to shell into a container, run the following:

```bash
docker exec -it <container_name> /bin/bash
```

Or if you would like to mount a directory:

```bash
docker exec -v `pwd`:/workspace -it <container_name> /bin/bash
```

All images have `bash` installed.

# Checking the build version

If you are experiencing issues with a container, it can be useful to determine the image digest. As each image is deterministic, the digest should map to specific versions.

To obtain the build version for the container:

```bash
docker inspect -f '{{ index .Config.Labels "org.opencontainers.image.release" }}' <container_name>
```

Or the image:

```bash
docker inspect -f '{{ index .Config.Labels "org.opencontainers.image.release" }}' ghcr.io/cardboardci/<image_name>
```
