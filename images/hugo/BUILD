load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "hugo",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'dpkg'],
    label_schema = {
        "{summary}" :  "Hugo static site generator",
        "{description}" : "Hugo is an open-source static site generator",
    }
)
