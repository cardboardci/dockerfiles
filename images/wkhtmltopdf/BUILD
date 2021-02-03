load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "deb_download_and_install")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "openssl",
        "build-essential",
        "xz-utils",
        "xfonts-100dpi",
        "xfonts-75dpi",
        "xfonts-base",
        "fonts-roboto",
        "fonts-inconsolata",
        "ttf-mscorefonts-installer",
        "fontconfig",
        "xorg",
        "wget",
        "zlib1g",
        "libpng16-16",
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
    packages = [
        "https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.focal_amd64.deb",
    ],
    image = ":apt_get_installed.tar",
)

container_image(
    name = "image",
    base = ":bin_install_commit.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    user = "cardboardci",
    labels = {
        "maintainer":"CardboardCI",
        "org.opencontainers.image.title":"wkhtmltopdf",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"Render HTML into PDFs",
        "org.opencontainers.image.description":"wkhtmltopdf is a command line tools to render HTML into PDF",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/wkhtmltopdf",
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
        "//images/wkhtmltopdf/test_configs:command.yaml",
        "//images/wkhtmltopdf/test_configs:metadata.yaml",
    ],
    image = ":image",
)