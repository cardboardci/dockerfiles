load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "@cardboardci_base//image",
    packages = [
        "ruby2.7",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "@cardboardci_base//image",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

container_image(
    name = "apt_get_done",
    base = ":apt_get_installed.tar",
)

container_run_and_commit(
    name = "gem_install",
    commands = [
        "ruby -v",
        # "gem install rake:13.0.3",
        # "gem install rubocop",
    ],
    image = ":apt_get_done.tar",
)

container_image(
    name = "image",
    base = ":gem_install_commit.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    user = "cardboardci",
    labels = {
        "maintainer":"CardboardCI",
        "org.opencontainers.image.title":"rubocop",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"Ruby static code analyzer",
        "org.opencontainers.image.description":"A Ruby static code analyzer and formatter, based on the community Ruby style guide",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/rubocop",
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
        "//images/rubocop/test_configs:command.yaml",
        "//images/rubocop/test_configs:metadata.yaml",
    ],
    image = ":image",
)