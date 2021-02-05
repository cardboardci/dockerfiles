load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "@ubuntu//image",
    packages = [
        "bash",
        "ca-certificates",
        "curl",
        "git",
        "jq",
        "locales",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "@ubuntu//image",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

container_run_and_commit(
    name = "bin_install",
    commands = [
        "groupadd -r -g 180000 cardboardci",
        "useradd --uid=180000 --gid=180000 --create-home cardboardci",
        "locale-gen en_US.UTF-8",
    ],
    image = ":apt_get_installed.tar",
)

container_image(
    name = "image",
    base = ":bin_install_commit.tar",
    cmd = ["/bin/bash"],
    entrypoint = "",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.opencontainers.image.title": "base",
        "org.opencontainers.image.release": "CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor": "cardboardci",
        "org.opencontainers.image.architecture": "amd64",
        "org.opencontainers.image.summary": "CardboardCI BaseImage",
        "org.opencontainers.image.description": "A base image with common dependencies for CI environments",
        "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/base",
        "org.opencontainers.image.url": "https://github.com/cardboardci/dockerfiles/base",
        "org.opencontainers.image.documentation": "https://cardboardci.jrbeverly.me",
        "org.cardboardci.image.user": "cardboardci",
        "org.cardboardci.image.uid": "180000",
        "org.cardboardci.image.group": "cardboardci",
        "org.cardboardci.image.gid": "180000",
    },
    visibility = ["//visibility:public"],
    volumes = [
        "/workspace",
    ],
    workdir = "/workspace",
)

container_test(
    name = "test",
    configs = [
        "//images/base/test_configs:command.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
