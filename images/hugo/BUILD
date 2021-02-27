load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@cardboardci//rules:wrappers.bzl", "deb_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image", "cardboardci_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "libstdc++6",
        "python-pygments",
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
        "https://github.com/gohugoio/hugo/releases/download/v0.69.0/hugo_extended_0.69.0_Linux-64bit.deb",
    ],
)

cardboardci_image(
    name = "image",
    base = ":apt_get_installed.tar",
    labels = {
        "org.opencontainers.image.title": "hugo",
        "org.opencontainers.image.summary": "Hugo static site generator",
        "org.opencontainers.image.description": "Hugo is an open-source static site generator",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/hugo/test_configs:command.yaml",
    ],
    image = ":image",
)
