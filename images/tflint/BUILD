load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "zip_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "curl",
        "unzip",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

zip_download_and_install(
    name = "bin_install",
    image = ":apt_get_installed.tar",
    package = "https://github.com/wata727/tflint/releases/download/v0.23.1/tflint_linux_amd64.zip",
    target = "/usr/local/bin",
)

cardboardci_image(
    name = "image",
    base = ":bin_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "tflint",
        "org.opencontainers.image.summary": "Terraform linter",
        "org.opencontainers.image.description": "TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan",
    },
)

container_test(
    name = "test",
    configs = [
        "//images/tflint/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
