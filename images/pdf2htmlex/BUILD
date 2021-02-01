load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "cmake",
        "autotools-dev",
        "libjpeg-dev",
        "libgif-dev",
        "libxt-dev",
        "autoconf",
        "automake",
        "libtool",
        "bzip2",
        "libxml2-dev",
        "libuninameslist-dev",
        "libspiro-dev",
        "libpango1.0-dev",
        "libcairo2-dev",
        "chrpath",
        "uuid-dev",
        "uthash-dev",
        "libltdl-dev",
        "build-essential",
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

container_run_and_commit(
    name = "bin_install",
    commands = [
        "wget https://github.com/pdf2htmlEX/pdf2htmlEX/releases/download/v0.18.8.rc1/pdf2htmlEX-0.18.8.rc1-master-20200630-Ubuntu-focal-x86_64.deb --directory-prefix=/tmp/deb",
        "dpkg -i /tmp/deb/*.deb",
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
        "org.opencontainers.image.title":"pdf2htmlex",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"PDF 2 HTML",
        "org.opencontainers.image.description":"Convert PDF to HTML without losing text or format",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/pdf2htmlex",
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
        "//images/pdf2htmlex/test_configs:command.yaml",
        "//images/pdf2htmlex/test_configs:metadata.yaml",
    ],
    image = ":image",
)