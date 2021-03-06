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
        "surge",
    ],
)

cardboardci_image(
    name = "image",
    base = ":npm_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "surge",
        "org.opencontainers.image.summary": "Static web publishing",
        "org.opencontainers.image.description": "Surge is static web publishing for Front-End Developers, right from the CLI",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/surge/test_configs:command.yaml",
    ],
    image = ":image",
)
