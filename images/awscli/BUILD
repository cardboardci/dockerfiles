load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

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

container_image(
    name = "image",
    base = ":apt_get_installed.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.opencontainers.image.title": "awscli",
        "org.opencontainers.image.release": "CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor": "cardboardci",
        "org.opencontainers.image.architecture": "amd64",
        "org.opencontainers.image.summary": "AWS CLI",
        "org.opencontainers.image.description": " The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services",
        "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/images/awscli",
    },
    user = "cardboardci",
    volumes = [
        "/workspace",
    ],
    workdir = "/workspace",
)

container_test(
    name = "test",
    configs = [
        "//images/awscli/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
