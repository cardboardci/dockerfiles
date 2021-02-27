load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "binary_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image", "cardboardci_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = ["wget"],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

binary_download_and_install(
    name = "bin_install",
    image = ":apt_get_installed.tar",
    package = "https://github.com/dropbox/dbxcli/releases/download/v3.0.0/dbxcli-linux-amd64",
    target = "/usr/bin/dbxcli",
)

cardboardci_image(
    name = "image",
    base = ":bin_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "dbxcli",
        "org.opencontainers.image.summary": "Dropbox CLI",
        "org.opencontainers.image.description": "A command line client for Dropbox built using the Go SDK.",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/dbxcli/test_configs:command.yaml",
    ],
    image = ":image",
)
