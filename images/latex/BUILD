load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "latex",
    digest = COMMON_DIGEST,
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "Document typesetting",
        "{description}" : "LaTeX is a sys­tem for com­puter type­set­ting of doc­u­ments",
    }
)
