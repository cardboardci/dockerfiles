load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

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

container_image(
    name = "image",
    base = ":bin_install_commit.tar",
    cmd = ["/bin/bash"],
    entrypoint = "",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.opencontainers.image.title": "gitlab",
        "org.opencontainers.image.release": "CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor": "cardboardci",
        "org.opencontainers.image.architecture": "amd64",
        "org.opencontainers.image.summary": "GitLab CLI",
        "org.opencontainers.image.description": "Lab wraps Git or Hub, making it simple to clone, fork, and interact with repositories on GitLab",
        "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/images/gitlab",
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
        "//images/gitlab/test_configs:command.yaml",
        "//images/gitlab/test_configs:metadata.yaml",
    ],
    image = ":image",
)
