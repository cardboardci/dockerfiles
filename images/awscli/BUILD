load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST", "docker_container")

dockerfile(
    name = "dockerfile",
    image = "awscli",
    digest = COMMON_DIGEST,
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "AWS CLI",
        "{description}" : "The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services",
    }
)

docker_container(
    name = "image",
    srcs = glob([
        "provision/*",
        "rootfs/*",
    ]) + [".dockerignore"],
    rule = "awscli",
)
