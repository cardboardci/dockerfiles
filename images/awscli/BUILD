load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

# download_pkgs(
#     name = "apt_get_download",
#     image_tar = "@cardboardci_base//image",
#     packages = ["awscli=1.18.69-1ubuntu0.16.04.1"],
# )
container_run_and_commit(
    name = "install_adjustments",
    commands = [
        "apt-get update -y",
        "apt-get install --no-install-recommends -y -q -o Dir::Cache=\"/tmp/install\" -o Dir::Cache::archives=\".\" python3 python3-pip --download-only",
        "which dpkg-deb",
    ],
    image = "@cardboardci_base//image",
)

download_pkgs(
    name = "apt_get_download_awscli",
    image_tar = "@cardboardci_base//image",
    # image_tar = "@ubuntu//image",
    packages = [
        "python3",
        "python3-pip",
    ],
)


# install_pkgs(
#     name = "apt_get_installed",
#     image_tar = "@cardboardci_base//image",
#     installables_tar = ":apt_get_download.tar",
#     installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
#     output_image_name = "apt_get_installed",
# )

# container_image(
#     name = "image",
#     base = ":apt_get_installed.tar",
#     env = {
#         "CARDBOARDCI_WORKSPACE": "/workspace",
#     },
#     files = glob(["image_data/*"]),
#     labels = {
#         "maintainer":"CardboardCI",
#         "org.opencontainers.image.title":"awscli",
#         "org.opencontainers.image.release":"CardboardCI version:0.0.0",
#         "org.opencontainers.image.vendor":"cardboardci",
#         "org.opencontainers.image.architecture":"amd64",
#         "org.opencontainers.image.summary":"AWS CLI",
#         "org.opencontainers.image.description":" The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services",
#         "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/awscli",
#     },
#     volumes = [
#         "/workspace",
#     ],
#     workdir = "/workspace",
# )

# container_test(
#     name = "test",
#     configs = glob(["test_configs/*"]),
#     image = ":image",
# )