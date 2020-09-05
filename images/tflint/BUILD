load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "tflint",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'zip'],
    label_schema = {
        "{summary}" : "Terraform linter",
        "{description}" : "TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan",
    }
)
