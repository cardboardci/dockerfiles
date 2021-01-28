load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

## aptget

download_pkgs(
    name = "apt_get_download",
    image_tar = "@cardboardci_base//image",
    packages = [
        "nodejs=4.2.6~dfsg-1ubuntu4.2",
        "npm=3.5.2-0ubuntu4",
    ],
)

install_pkgs(
    name = "apt_get_install",
    image_tar = "@cardboardci_base//image",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_install",
)

container_image(
    name = "apt_get_installed",
    base = ":apt_get_install.tar",
    cmd = "",
    entrypoint = "",
)

## npm

container_run_and_commit(
    name = "npm_install",
    commands = [
        "npm install -g -y bats@1.2.1",
    ],
    image = ":apt_get_installed.tar",
)

##

container_image(
    name = "image",
    base = ":npm_install_commit.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    user = "cardboardci",
    labels = {
        "maintainer":"CardboardCI",
        "org.opencontainers.image.title":"bats",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"Bash Automated Testing System",
        "org.opencontainers.image.description":"Bats is most useful when testing software written in Bash, but you can use it to test any UNIX program",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/bats",
    },
    volumes = [
        "/workspace",
    ],
    workdir = "/workspace",
)

container_test(
    name = "test",
    configs = [
        "//images/bats/test_configs:command.yaml",
        "//images/bats/test_configs:metadata.yaml",
    ],
    image = ":image",
)