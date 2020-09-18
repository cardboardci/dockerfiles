load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("//rules:apt_download.bzl", "download_apt_pkg")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")

## Packages

download_pkgs(
    name = "pkgs_dwnld",
    image_tar = "@ubuntu//image",
    packages = [
        "python3",
        "python3-pip",
    ],
)

download_apt_pkg(
    name = "apt_get_python3",
    image_tar = "@ubuntu//image",
    package = "python3",
    version = "1.2.3",
    sum = "asdfasdf",
)

install_pkgs(
    name = "install_pkgs",
    image_tar = "@ubuntu//image",
    installables_tar = ":apt_get_python3.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "test_pkgs",
)

install_pkgs(
    name = "pkgs",
    image_tar = "@ubuntu//image",
    installables_tar = ":pkgs_dwnld.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "pkgs",
)

## Container

container_image(
    name = "pip_install",
    base = ":pkgs.tar",
    cmd = "",
    entrypoint = "",
)

container_run_and_commit(
    name = "awscli_install",
    commands = [
        "python3 -m pip install --upgrade pip setuptools wheel",
        "python3 -m pip install awscli",
    ],
    image = ":pip_install.tar",
)

container_image(
    name = "image",
    base = ":awscli_install_commit.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.label-schema.schema-version": "1.0",
        "org.label-schema.name": "awscli",
        "org.label-schema.version": "1.16",
        "org.label-schema.release=": "CardboardCI version:1.16",
        "org.label-schema.vendor": "cardboardci",
        "org.label-schema.architecture": "amd64",
        "org.label-schema.summary": "AWS CLI",
        "org.label-schema.description": "The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services",
        "org.label-schema.url": "https://github.com/cardboardci/docker-awscli",
        "org.label-schema.changelog-url": "https://github.com/cardboardci/docker-awscli",
        "org.label-schema.authoritative-source-url": "https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/awscli",
        "org.label-schema.distribution-scope": "public",
        "org.label-schema.vcs-type": "git",
        "org.label-schema.vcs-url": "https://github.com/cardboardci/docker-awscli",
    },

    # The path /workspace is made available for all development work
    volumes = [
        "/workspace",
    ],
    workdir = "/workspace",
)

# Tests

container_test(
    name = "test",
    configs = [
        "//bazel/test_configs:command.yaml",
        "//bazel/test_configs:metadata.yaml",
    ],
    image = ":image",
)