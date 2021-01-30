load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "@cardboardci_base//image",
    packages = ["wget"],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "@cardboardci_base//image",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

container_run_and_commit(
    name = "bin_install",
    commands = [
        "wget https://github.com/dropbox/dbxcli/releases/download/v3.0.0/dbxcli-linux-amd64 -O /usr/bin/dbxcli",
        "chmod +x /usr/bin/dbxcli",
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
        "org.opencontainers.image.title":"dbxcli",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"Dropbox CLI",
        "org.opencontainers.image.description":"A command line client for Dropbox built using the Go SDK.",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/dbxcli",
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
        "//images/dbxcli/test_configs:command.yaml",
        "//images/dbxcli/test_configs:metadata.yaml",
    ],
    image = ":image",
)