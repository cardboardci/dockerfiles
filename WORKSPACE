workspace(name = "cardboardci")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "4521794f0fba2e20f3bf15846ab5e01d5332e587e9ce81629c7f96c793bb7036",
    strip_prefix = "rules_docker-0.14.4",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.14.4/rules_docker-v0.14.4.tar.gz"],
)

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)
container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@io_bazel_rules_docker//repositories:pip_repositories.bzl", "pip_deps")

pip_deps()

load("//rules:images.bzl", "images")
images()

# Pinned base image for working with pdfhtmlex
load("@io_bazel_rules_docker//container:container.bzl", "container_pull")
container_pull(
    name = "cardboardci_pdf2htmlex",
    registry = "ghcr.io",
    repository = "cardboardci/base",
    digest = "sha256:bbf36e6f9e1ff487b92a81e0a1f5fbad9bac9453dbdd3ae6c06631e27999238c",
)