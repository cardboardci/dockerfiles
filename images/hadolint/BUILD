load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "binary_download_and_install", "cardboardci_image")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "libgmp10",
        "wget",
    ],
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
    package = "https://github.com/hadolint/hadolint/releases/download/v1.17.5/hadolint-Linux-x86_64",
    target = "/usr/bin/hadolint",
)

cardboardci_image(
    name = "image",
    base = ":bin_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "hadolint",
        "org.opencontainers.image.summary": "Dockerfile linter",
        "org.opencontainers.image.description": "Dockerfile linter, validate inline bash, written in Haskell",
    },
)

container_test(
    name = "test",
    configs = [
        "//images/hadolint/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
