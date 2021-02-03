load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//contrib:test.bzl", "container_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "curl",
        "less",
        "libc6",
        "libgcc1",
        "libgssapi-krb5-2",
        "liblttng-ust0",
        "libssl1.1",
        "libstdc++6",
        "locales",
        "wget",
        "zlib1g",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

container_image(
    name = "apt_get_done",
    base = ":apt_get_installed.tar",
)

container_run_and_commit(
    name = "bin_install",
    commands = [
        "wget http://ftp.us.debian.org/debian/pool/main/i/icu/libicu57_57.1-6+deb9u4_amd64.deb",
        "dpkg -i libicu57_57.1-6+deb9u4_amd64.deb",
        "rm libicu57_57.1-6+deb9u4_amd64.deb",
        "mkdir -p /home/cardboardci/.local/share/powershell/ /opt/microsoft/powershell/7",
        "chown -R cardboardci:cardboardci /home/cardboardci/ /opt/microsoft/",
        "curl -L  https://github.com/PowerShell/PowerShell/releases/download/v7.1.0/powershell-7.1.0-linux-x64.tar.gz -o /tmp/powershell.tar.gz",
        "tar zxf /tmp/powershell.tar.gz -C /opt/microsoft/powershell/7",
        "ln -s /opt/microsoft/powershell/7/pwsh /usr/bin/pwsh",
        "chmod +x /opt/microsoft/powershell/7/pwsh",
        "pwsh -c 'Install-Module -Name PSScriptAnalyzer -RequiredVersion 1.18.3 -Scope AllUsers -Force'",
        "pwsh -c 'Import-Module PSScriptAnalyzer'",
    ],
    image = ":apt_get_done.tar",
)

container_image(
    name = "image",
    base = ":bin_install_commit.tar",
    cmd = ["/bin/bash"],
    directory = "/usr/bin/",
    entrypoint = "",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    files = glob(["image_data/usr/bin/*"]),
    labels = {
        "maintainer": "CardboardCI",
        "org.opencontainers.image.title": "psscriptanalyzer",
        "org.opencontainers.image.release": "CardboardCI version:0.0.0",
        "org.opencontainers.image.vendor": "cardboardci",
        "org.opencontainers.image.architecture": "amd64",
        "org.opencontainers.image.summary": "Powershell linter",
        "org.opencontainers.image.description": "PSScriptAnalyzer is a static code checker for Windows PowerShell modules and scripts",
        "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/images/psscriptanalyzer",
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
        "//images/psscriptanalyzer/test_configs:command.yaml",
        "//images/psscriptanalyzer/test_configs:metadata.yaml",
    ],
    image = ":image",
)
