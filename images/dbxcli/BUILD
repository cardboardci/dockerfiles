load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "dbxcli",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'bin'],
    label_schema = {
        "{summary}" : "Dropbox CLI",
        "{description}" : "A command line client for Dropbox built using the Go SDK.",
    }
)
