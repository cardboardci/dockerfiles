load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "wkhtmltopdf",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'dpkg'],
    label_schema = {
        "{summary}" : "Render HTML into PDFs",
        "{description}" : "wkhtmltopdf is a command line tools to render HTML into PDF",
    }
)
