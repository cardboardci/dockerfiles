load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@cardboardci//rules:wrappers.bzl", "npm_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image", "cardboardci_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "nodejs",
        "npm",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

npm_download_and_install(
    name = "npm_install",
    image = ":apt_get_installed.tar",
    packages = [
        "markdownlint-cli",
    ],
)

cardboardci_image(
    name = "image",
    base = ":npm_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "markdownlint",
        "org.opencontainers.image.summary": "NodeJS linter",
        "org.opencontainers.image.description": "A Node.js style checker and lint tool for Markdown/CommonMark files",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/markdownlint/test_configs:command.yaml",
    ],
    image = ":image",
)
