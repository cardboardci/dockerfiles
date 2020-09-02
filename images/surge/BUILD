load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "surge",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "Static web publishing",
        "{description}" : "Surge is static web publishing for Front-End Developers, right from the CLI",
    }
)
