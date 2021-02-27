"""
Definitions for the image to ensure consistency.
"""

load("@io_bazel_rules_docker//container:container.bzl", "container_image")

CARDBOARDCI_UID = "180000"
CARDBOARDCI_GID = "180000"

def cardboardci_image(name, base, labels, tars = []):
    container_image(
        name = name,
        base = base,
        cmd = ["/bin/bash"],
        entrypoint = "",
        env = {
            "CARDBOARDCI_WORKSPACE": "/workspace",
        },
        tars = tars,
        files = native.glob(["image_data/*"]),
        labels = {
            "maintainer": "CardboardCI",
            "org.opencontainers.image.title": labels["org.opencontainers.image.title"],
            "org.opencontainers.image.release": "CardboardCI version:0.0.0",
            "org.opencontainers.image.vendor": "cardboardci",
            "org.opencontainers.image.architecture": "amd64",
            "org.opencontainers.image.summary": labels["org.opencontainers.image.summary"],
            "org.opencontainers.image.description": labels["org.opencontainers.image.description"],
            "org.opencontainers.image.source": "https://github.com/cardboardci/dockerfiles/images/%s" % (labels["org.opencontainers.image.title"]),
            "org.opencontainers.image.url": "https://github.com/cardboardci/dockerfiles/tree/master/images/%s" % (labels["org.opencontainers.image.title"]),
            "org.opencontainers.image.documentation": "https://cardboardci.jrbeverly.me",
            "org.cardboardci.image.user": "cardboardci",
            "org.cardboardci.image.group": "cardboardci",
            "org.cardboardci.image.uid": CARDBOARDCI_UID,
            "org.cardboardci.image.gid": CARDBOARDCI_GID,
        },
        user = "cardboardci",
        volumes = [
            "/workspace",
        ],
        workdir = "/workspace",
    )
