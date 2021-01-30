load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "@cardboardci_base//image",
    packages = [
        "wget=1.17.1-1ubuntu1.5",
        "liblttng-ust0=2.7.1-1",
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
    directory = "/usr/bin/",
    files = glob(["image_data/usr/bin/*"]),
)

container_run_and_commit(
    name = "bin_install",
    commands = [
        "wget http://mirrors.edge.kernel.org/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3_amd64.deb --directory-prefix=/tmp/deb",
        "wget https://github.com/PowerShell/PowerShell/releases/download/v7.0.0/powershell_7.0.0-1.ubuntu.18.04_amd64.deb --directory-prefix=/tmp/deb",
        "dpkg -i /tmp/deb/*.deb",
        "mkdir -p /home/cardboardci/.local/share/powershell/",
        "chown -R cardboardci:cardboardci /home/cardboardci/ /opt/microsoft/",
        "pwsh -c 'Install-Module -Name PSScriptAnalyzer -RequiredVersion 1.18.3 -Scope AllUsers -Force'",
        "pwsh -c 'Import-Module PSScriptAnalyzer'",
        "chmod +x /usr/bin/PSFormatter",
        "chmod +x /usr/bin/PSScriptAnalyzer",
    ],
    image = ":apt_get_done.tar",
)

container_image(
    name = "image",
    base = ":bin_install_commit.tar",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    user = "cardboardci",
    labels = {
        "maintainer":"CardboardCI",
        "org.opencontainers.image.title":"psscriptanalyzer",
        "org.opencontainers.image.release":"CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor":"cardboardci",
        "org.opencontainers.image.architecture":"amd64",
        "org.opencontainers.image.summary":"Powershell linter",
        "org.opencontainers.image.description":"PSScriptAnalyzer is a static code checker for Windows PowerShell modules and scripts",
        "org.opencontainers.image.source":"https://github.com/cardboardci/dockerfiles/images/psscriptanalyzer",
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
        "//images/psscriptanalyzer/test_configs:command.yaml",
        "//images/psscriptanalyzer/test_configs:metadata.yaml",
    ],
    image = ":image",
)