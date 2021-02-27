load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:images.bzl", "cardboardci_image", "cardboardci_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = ["poppler-utils"],
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
        "org.opencontainers.image.title": "pdftools",
        "org.opencontainers.image.summary": "PDF CLIs",
        "org.opencontainers.image.description": " Command line tools for manipulating pdfs",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/pdftools/test_configs:command.yaml",
    ],
    image = ":image",
)
