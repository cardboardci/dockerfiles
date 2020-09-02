load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "hadolint",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'bin'],
    label_schema = {
        "{summary}" : "Dockerfile linter",
        "{description}" : "Dockerfile linter, validate inline bash, written in Haskell",
    }
)
