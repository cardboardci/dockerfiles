load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "deb_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "build-essential",
        "fontconfig",
        "fonts-inconsolata",
        "fonts-roboto",
        "libpng16-16",
        "openssl",
        "ttf-mscorefonts-installer",
        "wget",
        "xfonts-100dpi",
        "xfonts-75dpi",
        "xfonts-base",
        "xorg",
        "xz-utils",
        "zlib1g",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

deb_download_and_install(
    name = "bin_install",
    image = ":apt_get_installed.tar",
    packages = [
        "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.focal_amd64.deb",
    ],
)

cardboardci_image(
    name = "image",
    base = ":bin_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "wkhtmltopdf",
        "org.opencontainers.image.summary": "Render HTML into PDFs",
        "org.opencontainers.image.description": "wkhtmltopdf is a command line tools to render HTML into PDF",
    },
)

container_test(
    name = "test",
    configs = [
        "//images/wkhtmltopdf/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
