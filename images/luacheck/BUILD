load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "luacheck",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'lua'],
    label_schema = {
        "{summary}" : "Lua linter",
        "{description}" : "Luacheck is a static analyzer and a linter for Lua",
    }
)
