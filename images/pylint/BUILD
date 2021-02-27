load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "pip_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "python3",
        "python3-pip",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
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

cardboardci_image(
    name = "image",
    base = ":pip_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "pylint",
        "org.opencontainers.image.summary": "Python linter",
        "org.opencontainers.image.description": "Pylint is a Python static code analysis tool which looks for programming errors",
    },
)

container_test(
    name = "test",
    configs = [
        "//images/pylint/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
