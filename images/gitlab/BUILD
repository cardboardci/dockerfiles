load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")
load("@cardboardci//rules:images.bzl", "cardboardci_image")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "openssh-client",
        "vim-nox",
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
        "wget https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz -O /tmp/hub",
        "tar -xvzf /tmp/hub",
        "mv hub-linux-amd64-2.14.2/bin/hub /usr/bin/hub",
        "chmod +x /usr/bin/hub",
        "rm -rf hub*",
        "curl -sSL 'https://raw.githubusercontent.com/zaquestion/lab/master/install.sh' -o /tmp/install.sh",
        "bash /tmp/install.sh",
    ],
    image = ":apt_get_installed.tar",
)

cardboardci_image(
    name = "image",
    base = ":bin_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "gitlab",
        "org.opencontainers.image.summary": "GitLab CLI",
        "org.opencontainers.image.description": "Lab wraps Git or Hub, making it simple to clone, fork, and interact with repositories on GitLab",
    },
)

container_test(
    name = "test",
    configs = [
        "//images/gitlab/test_configs:command.yaml",
        "//tests:limited_user.yaml",
        "//tests:metadata.yaml",
    ],
    image = ":image",
)
