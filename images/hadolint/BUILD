load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "hadolint",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'bin'],
    label_schema = {
        "{summary}" : "Dockerfile linter",
        "{description}" : "Dockerfile linter, validate inline bash, written in Haskell",
    }
)
