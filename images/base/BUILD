load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

# TODO: Pinned versions to avoid bad version upgrades
# This just ensures that the base official image is upgraded to latest for packages
# Ideally this would pin the package versions of the official version, then upgrade on-demand
container_run_and_commit(
    name = "upgraded_base",
    commands = [
        "apt-get update -y",
        "apt-get upgrade -y",
        "apt-get clean",
        "rm -rf /var/lib/apt/lists/*"
    ],
    image = "@ubuntu//image",
)

download_pkgs(
    name = "apt_get_download",
    image_tar = ":upgraded_base_commit.tar",
    packages = [
        "git",
        "jq",
        "curl",
        "bash",
        "ca-certificates",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = ":upgraded_base_commit.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

container_run_and_commit(
    name = "bin_install",
    commands = [
        "groupadd -r cardboardci",
        "useradd --no-log-init -r -g cardboardci cardboardci",
        "mkdir -p /home/cardboardci",
        "chown cardboardci /home/cardboardci",
    ],
    image = ":apt_get_installed.tar",
)

container_image(
    name = "image",
    base = ":bin_install_commit.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    user = "cardboardci",
    labels = {
        "maintainer":"CardboardCI",
        "org.opencontainers.image.title":"base",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"CardboardCI BaseImage",
        "org.opencontainers.image.description":"A base image with common dependencies for CI environments",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/base",
    },
    volumes = [
        "/workspace",
    ],
    entrypoint = "",
    cmd = ["/bin/bash"],
    workdir = "/workspace",
)

container_test(
    name = "test",
    configs = [
        "//images/base/test_configs:command.yaml",
        "//images/base/test_configs:metadata.yaml",
    ],
    image = ":image",
)