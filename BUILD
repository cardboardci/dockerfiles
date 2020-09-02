load("@io_bazel_rules_docker//container:container.bzl", "container_image")

container_image(
    name = "baseimage",
    base = "@ubuntu_core//image",
    env = {
        "CARDBOARDCI_WORKSPACE": "/workspace",
    },
    labels = {
        "org.label-schema.name": "awscli",
        "org.label-schema.version": "1.16",
        "org.label-schema.release=": "CardboardCI version:1.16",
        "org.label-schema.summary": "AWS CLI",
        "org.label-schema.description": "The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services",
        "org.label-schema.url": "https://github.com/cardboardci/docker-awscli",
        "org.label-schema.changelog-url": "https://github.com/cardboardci/docker-awscli",
        "org.label-schema.authoritative-source-url": "https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/awscli",
        "org.label-schema.vcs-url": "https://github.com/cardboardci/docker-awscli",
    },
    volumes = [  "/workspace" ],
    workdir =  "/workspace",
    visibility = ["//visibility:public"]
)