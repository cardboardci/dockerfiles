load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "CARDBOARDCI_GID", "CARDBOARDCI_UID", "npm_download_and_install")

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

container_image(
    name = "image",
    base = ":npm_install_commit.tar",
    cmd = ["/bin/bash"],
    entrypoint = "",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.opencontainers.image.title": "surge",
        "org.opencontainers.image.release": "CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor": "cardboardci",
        "org.opencontainers.image.architecture": "amd64",
        "org.opencontainers.image.summary": "Static web publishing",
        "org.opencontainers.image.description": "Surge is static web publishing for Front-End Developers, right from the CLI",
        "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/images/surge",
        "org.opencontainers.image.url": "https://github.com/cardboardci/dockerfiles/surge",
        "org.opencontainers.image.documentation": "https://cardboardci.jrbeverly.me",
        "org.cardboardci.image.user": "cardboardci",
        "org.cardboardci.image.uid": CARDBOARDCI_UID,
        "org.cardboardci.image.group": "cardboardci",
        "org.cardboardci.image.gid": CARDBOARDCI_GID,
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
        "//images/surge/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
