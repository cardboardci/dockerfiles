load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "surge",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "Static web publishing",
        "{description}" : "Surge is static web publishing for Front-End Developers, right from the CLI",
    }
)
