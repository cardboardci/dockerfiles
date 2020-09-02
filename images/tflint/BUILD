load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "tflint",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'zip'],
    label_schema = {
        "{summary}" : "Terraform linter",
        "{description}" : "TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan",
    }
)
