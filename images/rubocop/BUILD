load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "gem_download_and_install")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "ruby2.7",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

gem_download_and_install(
    name = "gem_install",
    image = ":apt_get_installed.tar",
    packages = [
        "rake",
        "rubocop",
    ],
)

container_image(
    name = "image",
    base = ":gem_install_commit.tar",
    cmd = ["/bin/bash"],
    entrypoint = "",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.opencontainers.image.title": "rubocop",
        "org.opencontainers.image.release": "CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor": "cardboardci",
        "org.opencontainers.image.architecture": "amd64",
        "org.opencontainers.image.summary": "Ruby static code analyzer",
        "org.opencontainers.image.description": "A Ruby static code analyzer and formatter, based on the community Ruby style guide",
        "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/images/rubocop",
    },
    user = "cardboardci",
    volumes = [
        "/workspace",
    ],
    workdir = "/workspace",
)

container_test(
    name = "test",
    configs = [
        "//images/rubocop/test_configs:command.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
