# Limited Permissions

The default user configured on each of the images (`org.cardboardci.image.user`) does not have sudo permissions, and cannot install dependencies by default. Images are encouraged to be extended, rather than installing dependencies at runtime.

This can be inconvenient for experimentation with dependencies when trying to resolve an issue, but is intended to ensure that any rogue dependency cannot sneak into the software deployment pipeline without going through the necessary vetting procedures to be installable.

Additionally avoiding installation at runtime helps avoid flakeyness that can show up due to CDN outages, missing integrity checks or permanently moved resources.

## Pattern for Extension

To extend one of the images, the following is a common Dockerfile pattern:

```dockerfile
FROM ghcr.io/cardboardci/base:20210211
USER root

ENV DEPENDENCY_VERSION 5.10.15
RUN apt-get update && \
    apt-get install -y ... && \
    rm -rf /var/lib/apt/lists/*

USER cardboardci
```

And the following is an example using Bazel:

```starlark
container_pull(
    name = "cardboardci_base",
    digest = "sha256:some_digest_value_here",
    registry = "ghcr.io",
    repository = "cardboardci/base",
)

download_pkgs(
    name = "apt_get_download",
    image_tar = "@cardboardci_base//image",
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

## Chaining Images

Extending images to add additional dependencies should be used when working with tightly coupled actions or behaviours. Otherwise it is recommended to chain images together leveraging 'steps' offered by most continuous integration services. Chaining images allows for aggressive caching on build machines, and clear failure scenarios for continuous integration pipelines.

Bundling dependencies into large images can result in the pipeline becoming unwieldy and suspectible to dependency difficulties.
