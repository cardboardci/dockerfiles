load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")
load("@rules_pkg//:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "website_contents",
    srcs = ["mkdocs.yml"] + glob(["www/**/*", "public/**/*"]),
    strip_prefix = ".",
)

container_image(
    name = "packaged_mkdocs",
    base = "@mkdocs//image",
    tars = [":website_contents"],
    cmd = ["/bin/bash"],
    entrypoint = "",
)

# download_pkgs(
#     name = "apt_get_download",
#     image_tar = ":packaged_mkdocs.tar",
#     packages = [
#         "zip","unzip",
#     ],
# )

# install_pkgs(
#     name = "apt_get_installed",
#     image_tar = ":packaged_mkdocs.tar",
#     installables_tar = ":apt_get_download.tar",
#     installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
#     output_image_name = "apt_get_installed",
# )

container_run_and_extract( 
    name = "website",
    commands = [
        "mkdocs build --config-file /mkdocs.yml --site-dir /public",
        "tar -cvf /website.tar /public/.",
    ],
    docker_run_flags = [
        "-u",
        "root",
    ],
    extract_file = "/website.tar",
    image = ":packaged_mkdocs.tar",
    # image = ":apt_get_installed.tar",
)