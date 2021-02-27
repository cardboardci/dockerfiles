load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:wrappers.bzl", "cardboardci_image", "npm_download_and_install")

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
        "netlify-cli",
    ],
)

cardboardci_image(
    name = "image",
    base = ":npm_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "netlify",
        "org.opencontainers.image.summary": "Netlify CLI",
        "org.opencontainers.image.description": "Netlify builds, deploys and hosts your netlify services",
    },
)

container_test(
    name = "test",
    configs = [
        "//images/netlify/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
