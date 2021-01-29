load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

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

container_image(
    name = "apt_get_done",
    base = ":apt_get_installed.tar",
)

container_run_and_commit(
    name = "pip_install",
    commands = [
        "python3 -m pip install --upgrade pip==21.0 setuptools==52.0.0 wheel==0.36.2",
        "python3 -m pip install pylint==2.4.4",
    ],
    image = ":apt_get_done.tar",
)

container_image(
    name = "image",
    base = ":pip_install_commit.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    user = "cardboardci",
    labels = {
        "maintainer":"CardboardCI",
        "org.opencontainers.image.title":"pylint",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"Python linter",
        "org.opencontainers.image.description":"Pylint is a Python static code analysis tool which looks for programming errors",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/pylint",
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
        "//images/pylint/test_configs:command.yaml",
        "//images/pylint/test_configs:metadata.yaml",
    ],
    image = ":image",
)