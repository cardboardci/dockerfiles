load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "stylelint",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "Style linter",
        "{description}" : "A mighty, modern style linter",
    }
)
