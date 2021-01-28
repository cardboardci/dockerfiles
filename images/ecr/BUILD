load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "@cardboardci_base//image",
    packages = [
        "awscli=1.18.69-1ubuntu0.16.04.1",
        "docker.io=18.09.7-0ubuntu1~16.04.7",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "@cardboardci_base//image",
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
    user = "cardboardci",
    labels = {
        "maintainer":"CardboardCI",
        "org.opencontainers.image.title":"ecr",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"AWS ECR",
        "org.opencontainers.image.description":"A unified tool to deploy Docker images to Amazon Elastic Container Registry (ECR)",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/ecr",
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
        "//images/ecr/test_configs:command.yaml",
        "//images/ecr/test_configs:metadata.yaml",
    ],
    image = ":image",
)