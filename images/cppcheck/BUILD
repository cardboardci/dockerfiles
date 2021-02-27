load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@cardboardci//rules:images.bzl", "cardboardci_image", "cardboardci_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "build-essential",
        "cppcheck",
        "libpcre3-dev",
        "python-pygments",
        "python3",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

cardboardci_image(
    name = "image",
    base = ":apt_get_installed.tar",
    labels = {
        "org.opencontainers.image.title": "cppcheck",
        "org.opencontainers.image.summary": "C++ linter",
        "org.opencontainers.image.description": "Static analysis of C/C++ code",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/cppcheck/test_configs:command.yaml",
    ],
    image = ":image",
)
