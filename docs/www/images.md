https://squidfunk.github.io/mkdocs-material/reference/data-tables/

The aim of this should be to list the most recent tags for each of the images.
Query registry and get list of them
Then emit them from here

## Tagging Strategy

Every new release of the image includes three tags: version, date and `latest`. These tags can be described as such:

-   `latest`: The most-recently released version of an image. (`cardboardci/awscli:latest`)
-   `<version>`: The most-recently released version of an image for that version of the tool. (`cardboardci/awscli:1.0.0`)
-   `<version-date>`: The version of the tool released on a specific date (`cardboarci/awscli:1.0.0-20190101`)

We recommend using the digest for the docker image, or pinning to the version-date tag. If you are unsure how to get the digest, you can retrieve it for any image with the following command:

```bash
docker pull cardboardci/awscli:latest
docker inspect --format='{{index .RepoDigests 0}}' cardboardci/awscli:latest
```
