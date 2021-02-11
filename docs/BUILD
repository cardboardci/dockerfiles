load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_extract")
load("@rules_pkg//:pkg.bzl", "pkg_tar")

pkg_tar(
    name = "website_contents",
    srcs = ["mkdocs.yml"] + glob([
        "www/**/*",
        "public/**/*",
    ]),
    strip_prefix = ".",
)

container_image(
    name = "packaged_mkdocs",
    base = "@mkdocs//image",
    cmd = ["/bin/bash"],
    entrypoint = "",
    tars = [":website_contents"],
)

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
)
