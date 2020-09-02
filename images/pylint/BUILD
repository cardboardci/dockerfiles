load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "pylint",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'pip'],
    label_schema = {
        "{summary}" : "Python linter",
        "{description}" : "Pylint is a Python static code analysis tool which looks for programming errors",
    }
)
