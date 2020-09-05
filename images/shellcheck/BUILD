load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "shellcheck",
    digest = COMMON_DIGEST,
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "Shell script static anaylsis",
        "{description}" : "ShellCheck is a static anaylsis tool that automatically finds bugs in your shell scripts",
    }
)
