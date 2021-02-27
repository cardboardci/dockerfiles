load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "deb_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "autoconf",
        "automake",
        "autotools-dev",
        "build-essential",
        "bzip2",
        "chrpath",
        "cmake",
        "libcairo2-dev",
        "libgif-dev",
        "libjpeg-dev",
        "libltdl-dev",
        "libpango1.0-dev",
        "libspiro-dev",
        "libtool",
        "libuninameslist-dev",
        "libxml2-dev",
        "libxt-dev",
        "uthash-dev",
        "uuid-dev",
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

deb_download_and_install(
    name = "bin_install",
    image = ":apt_get_installed.tar",
    packages = [
        "https://github.com/pdf2htmlEX/pdf2htmlEX/releases/download/v0.18.8.rc1/pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb",
    ],
)

cardboardci_image(
    name = "image",
    base = ":bin_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "pdf2htmlex",
        "org.opencontainers.image.summary": "PDF 2 HTML",
        "org.opencontainers.image.description": "Convert PDF to HTML without losing text or format",
    },
)

container_test(
    name = "test",
    configs = [
        "//images/pdf2htmlex/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
