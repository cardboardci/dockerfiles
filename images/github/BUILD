load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "github",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'dpkg'],
    label_schema = {
        "{summary}" : "GitHub CLI",
        "{description}" : "A command-line tool that makes git easier to use with GitHub",
    }
)
