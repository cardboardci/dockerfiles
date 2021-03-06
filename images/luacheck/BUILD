load("@io_bazel_rules_docker//docker/package_managers:download_pkgs.bzl", "download_pkgs")
load("@io_bazel_rules_docker//docker/package_managers:install_pkgs.bzl", "install_pkgs")
load("@cardboardci//rules:wrappers.bzl", "luacheck_download_and_install")
load("@cardboardci//rules:images.bzl", "cardboardci_image", "cardboardci_test")

download_pkgs(
    name = "apt_get_download",
    image_tar = "//images/base:image.tar",
    packages = [
        "gcc",
        "lua-sec",
        "luarocks",
    ],
)

install_pkgs(
    name = "apt_get_installed",
    image_tar = "//images/base:image.tar",
    installables_tar = ":apt_get_download.tar",
    installation_cleanup_commands = "rm -rf /var/lib/apt/lists/*",
    output_image_name = "apt_get_installed",
)

luacheck_download_and_install(
    name = "lua_install",
    image = ":apt_get_installed.tar",
    packages = [
        "luacheck",
    ],
)

cardboardci_image(
    name = "image",
    base = ":lua_install_commit.tar",
    labels = {
        "org.opencontainers.image.title": "luacheck",
        "org.opencontainers.image.summary": "Lua linter",
        "org.opencontainers.image.description": "Luacheck is a static analyzer and a linter for Lua",
    },
)

cardboardci_test(
    name = "test",
    configs = [
        "//images/luacheck/test_configs:command.yaml",
    ],
    image = ":image",
)
