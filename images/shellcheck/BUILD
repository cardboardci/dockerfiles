load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "shellcheck",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "Shell script static anaylsis",
        "{description}" : "ShellCheck is a static anaylsis tool that automatically finds bugs in your shell scripts",
    }
)
