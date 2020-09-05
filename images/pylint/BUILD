load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "pylint",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'pip'],
    label_schema = {
        "{summary}" : "Python linter",
        "{description}" : "Pylint is a Python static code analysis tool which looks for programming errors",
    }
)
