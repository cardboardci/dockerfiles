load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "pdf2htmlex",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'install'],
    label_schema = {
        "{summary}" : "PDF 2 HTML",
        "{description}" : "Convert PDF to HTML without losing text or format",
    }
)
