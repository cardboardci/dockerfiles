load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "wkhtmltopdf",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'dpkg'],
    label_schema = {
        "{summary}" : "Render HTML into PDFs",
        "{description}" : "wkhtmltopdf is a command line tools to render HTML into PDF",
    }
)
