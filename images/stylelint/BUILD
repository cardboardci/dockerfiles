load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "stylelint",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "Style linter",
        "{description}" : "A mighty, modern style linter",
    }
)
