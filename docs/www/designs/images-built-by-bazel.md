# Image built by Bazel

## Abstract

Images built with Dockerfiles have been using templating or layer-inefficient executions to better follow code-reuse standards. This has introduced more complexity and obfuscated the build harness. This design proposes leveraging bazel to build and test the docker images.

_This is an adapted design from the repository cardboardci/bazel-docker-awscli_

## Proposal

This proposes the introduction of bazel as both the build harness, and the mechanism to build the docker images. This would leverage `rules_docker` to handle the construction of the images, and orchestrate the execution of tests. This was evaluated in the proof of concept `bazel-docker-awscli` which determined that the lack of windows support was the limiting factor. Recent developments in environments-as-code has made that issue no longer a problem.

### Package Manager Rules

For the package managers that would need rules, they would follow the format of the existing `download_pkgs` (`f(deps[]) => tarball`). Most of the package managers used in CardboardCI have some way to download but not install the packages. Here are some examples of the rule usages:

```python
download_npm(
    name = "pkgs",
    image_tar = "@ubuntu//image",
    packages = [
        "surge:0.0.1",
    ],

    # Could we read all of the packages from a file?
    # packages_file = ":file"
)
```

If the rule could support a way of providing a file, then the same automated process as now could be used for upgrading the dependencies. The big problem I see with this is that if only 1 dependency changes, we must re-download all of the other dependencies. The option of bazel-ifying each dependency as a rule would create problems with updating (e.g. how to update version). This isn't too bad if there exists a file like so:

```python
load("@io_bazel_rules_docker//docker/package_managers:download_npm.bzl", "download_npm")

download_npm(
    name = "pkg_surge",
    image_tar = "@ubuntu//image",
    src = ":surge.dep"
)
```

With the `.dep` file looking something like this:

```toml
name="surge"
version="0.0.1"
```

## Full Example

An example of an image built with Bazel is included below:

```starlark
download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = ["awscli"],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

cardboardci_image(
    name = "image",
    base = ":apt_get_installed.tar",
    labels = {
        "org.opencontainers.image.title": "awscli",
        "org.opencontainers.image.summary": "AWS CLI",
        "org.opencontainers.image.description": " The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/awscli/test_configs:command.yaml",
    ],
    image = ":image",
)

```

## Retrospective Advantages

As the above is adapted from the existing proof of concept, the following are some notes made from the advantages of the bazel approach:

-   Tests can be split off into root levels, and applied to all images
-   Standards on metadata can be easily enforced for all images
-   Common fields in labeling can be abstracted away with macros
-   Base image can be built alongside existing images
-   Caching has the potential to speed up the build process (or reduce re-builds)
-   Sum verification of all dependencies can be strictly required
-   Vendoring of the dependencies can be done through macros or additional rules
