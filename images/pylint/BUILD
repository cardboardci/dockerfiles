load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "pip_download_and_install")

download_pkgs(
    name = "apt_get_download",
    image_tar = "@ubuntu//image",
    packages = [
        "python3",
        "python3-pip",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "@ubuntu//image",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

pip_download_and_install(
    name = "pip_install",
    image = ":apt_get_installed.tar",
    packages = [
        "pylint",
    ],
)

container_image(
    name = "image",
    base = ":pip_install_commit.tar",
    cmd = ["/bin/bash"],
    entrypoint = "",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.opencontainers.image.title": "pylint",
        "org.opencontainers.image.release": "CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor": "cardboardci",
        "org.opencontainers.image.architecture": "amd64",
        "org.opencontainers.image.summary": "Python linter",
        "org.opencontainers.image.description": "Pylint is a Python static code analysis tool which looks for programming errors",
        "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/images/pylint",
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
        "//images/pylint/test_configs:command.yaml",
        "//images/pylint/test_configs:metadata.yaml",
    ],
    image = ":image",
)
