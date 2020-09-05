load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "htmlhint",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "HTML linter",
        "{description}" : "The static code analysis tool you need for your HTML",
    }
)
