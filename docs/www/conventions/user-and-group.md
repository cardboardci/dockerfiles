# Understanding the User and Group

Docker images often are configured to run in the `root` user domain of an image. This kind of elevated access for processes inside the container is not necessary. The common scenario for these images is to run as command working off the contents of a mounted volume.

Continuous integration services will often make use of the `--user` flag to use a reduced permission level for clusters. When running locally, the `--user` flag may not always be specified. In these cases, the cardboardci user acts as a user with minimum permissions to work with the `/workspace` directory.

## Verify the user

You can see the properties of the default user by running `id` on the image:

```bash
docker run cardboardi/<image>:edge id
```

## Labels

Properties of the default user for every image are made available with the label namespace `org.cardboardci.image.`. The following are properties that exist within this namespace:

-   `user` - The name of the default user
-   `uid` - The User identifier of the default user
-   `group` - The name of the default user group
-   `gid` - The Group identifier of the default user

To obtain any of the properties listed above, you can run this for the container:

```bash
docker inspect -f '{{ index .Config.Labels "org.cardboardci.image.<property>" }}' <container_name>
```

Or the image:

```bash
docker inspect -f '{{ index .Config.Labels "org.cardboardci.image.<property>" }}' ghcr.io/cardboardci/<image_name>
```

## Checking the user

If you are experiencing issues with one of the containers, it can be useful to check if the issue is due to permissions. Running the container with the root flag (`--user root`) or interactively debugging can be helpful.

To run a container with an interactive shell:

```bash
docker exec --user 'cardboardci' -it <container_name> /bin/bash
```

Or as the root user:

```bash
docker exec --user 'cardboardci' -it <container_name> /bin/bash
```
