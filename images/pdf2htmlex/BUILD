load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "@cardboardci_base//image",
    packages = [
        "cmake=3.5.1-1ubuntu3",
        "autotools-dev=20150820.1",
        "libjpeg-dev=8c-2ubuntu8",
        "libgif-dev=5.1.4-0.3~16.04.1",
        "libxt-dev=1:1.1.5-0ubuntu1",
        "autoconf=2.69-9",
        "automake=1:1.15-4ubuntu1",
        "libtool=2.4.6-0.1",
        "bzip2=1.0.6-8ubuntu0.2",
        "libxml2-dev=2.9.3+dfsg1-1ubuntu0.7",
        "libuninameslist-dev=0.5.20150701-1",
        "libspiro-dev=1:0.5.20150702-4",
        "libpango1.0-dev=1.38.1-1",
        "libcairo2-dev=1.14.6-1",
        "chrpath=0.16-1",
        "uuid-dev=2.27.1-6ubuntu3.10",
        "uthash-dev=1.9.9.1+git20151125-1",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "@cardboardci_base//image",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

container_run_and_commit(
    name = "bin_install",
    commands = [
        "apt-get update",
        "apt-get install -qq libtiff4-dev libpng12-dev",
        "git clone https://github.com/coolwanglu/fontforge.git fontforge.git",
        "cd fontforge.git",
        "git checkout pdf2htmlEX",
        "./autogen.sh",
        "./configure",
        "make V=1",
        "make install",
        "apt-get install -qq libpoppler-glib-dev",
        "rm -rf var/cache/archives/*",
        "git clone https://github.com/coolwanglu/pdf2htmlEX.git",
        "cd pdf2htmlEX",
        "cmake .",
        "make",
        "make install",
        "mkdir /src",
    ],
    image = ":apt_get_installed.tar",
)

container_image(
    name = "image",
    base = ":apt_get_installed.tar",
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