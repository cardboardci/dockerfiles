load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "pdf2htmlex",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'install'],
    label_schema = {
        "{summary}" : "PDF 2 HTML",
        "{description}" : "Convert PDF to HTML without losing text or format",
    }
)
