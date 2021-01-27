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
        registry = "index.docker.io",
        repository = "library/ubuntu",
        digest = "sha256:edf232ee7dc18c57c063bc83533ef2c03c6dfae55a0124f7d372aed51cd1d9c8",
        # registry = "ghcr.io",
        # repository = "cardboardci/base",
        # digest = "sha256:74be5d6438114943e76d0f4f27d2ef5b05d873f07eb9a1ccd5e4735de1d43902",
    )
