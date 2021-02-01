load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def images():
    container_pull(
        name = "cardboardci_base",
        registry = "ghcr.io",
        repository = "cardboardci/base",
        digest = "sha256:0ce687225919e808935c00e9e0646b1fdbe5f953152b24be6ab25e4db92cc51b",
    )

    container_pull(
        name = "ubuntu",
        registry = "index.docker.io",
        repository = "library/ubuntu",
        # tag: ubuntu:focal-20210119
        digest = "sha256:3093096ee188f8ff4531949b8f6115af4747ec1c58858c091c8cb4579c39cc4e",
    )