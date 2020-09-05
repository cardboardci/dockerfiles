load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "hugo",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'dpkg'],
    label_schema = {
        "{summary}" :  "Hugo static site generator",
        "{description}" : "Hugo is an open-source static site generator",
    }
)
