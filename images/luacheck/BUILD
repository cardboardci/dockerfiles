load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "luacheck",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'lua'],
    label_schema = {
        "{summary}" : "Lua linter",
        "{description}" : "Luacheck is a static analyzer and a linter for Lua",
    }
)
