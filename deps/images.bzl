load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def images():
    container_pull(
        name = "ubuntu",
        registry = "index.docker.io",
        repository = "library/ubuntu",
        # tag: ubuntu:focal-20210119
        digest = "sha256:3093096ee188f8ff4531949b8f6115af4747ec1c58858c091c8cb4579c39cc4e",
    )