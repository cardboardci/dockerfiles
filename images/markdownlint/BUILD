load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "markdownlint",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "NodeJS linter",
        "{description}" : "A Node.js style checker and lint tool for Markdown/CommonMark files",
    }
)
