load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "github",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'dpkg'],
    label_schema = {
        "{summary}" : "GitHub CLI",
        "{description}" : "A command-line tool that makes git easier to use with GitHub",
    }
)
