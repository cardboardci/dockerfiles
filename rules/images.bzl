load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def images():
    container_pull(
        name = "ubuntu",
        registry = "index.docker.io",
        repository = "library/ubuntu",
        digest = "sha256:cb6a3a1298c73e3248b6b07ef3c78a14df4bade77b4be1ad725f8f5f2785e348",
    )

    container_pull(
        name = "cardboardci_base",
        registry = "ghcr.io",
        repository = "cardboardci/base",
        digest = "sha256:95898fc0dff94f43186942e59b9dfb39dd55256f9b943250222d58db26f23195",
    )
