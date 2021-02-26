"""
A collection of wrappers for installing from package managers.
"""

load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")
load("@io_bazel_rules_docker//container:container.bzl", "container_image")

CARDBOARDCI_UID = "180000"
CARDBOARDCI_GID = "180000"

def cardboardci_image(name, base, labels):
    container_image(
        name = name,
        base = base,
        cmd = ["/bin/bash"],
        entrypoint = "",
        env = {
            "CARDBOARDCI_WORKSPACE": "/workspace",
        },
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

def luacheck_download_and_install(name, image, packages):
    commands = ["luarocks install %s" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = commands,
        image = image,
    )

def pip_download_and_install(name, image, packages):
    commands = ["python3 -m pip install %s" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = ["python3 -m pip install --upgrade pip setuptools wheel"] + commands,
        image = image,
    )

def gem_download_and_install(name, image, packages):
    commands = ["gem install  %s" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = commands,
        image = image,
    )

def npm_download_and_install(name, image, packages):
    commands = ["npm install --ignore-scripts -g -y %s" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = commands,
        image = image,
    )

def binary_download_and_install(name, image, package, target):
    container_run_and_commit(
        name = name,
        commands = [
            "wget %s -O %s" % (package, target),
            "chmod +x %s" % (target),
        ],
        image = image,
    )

def deb_download_and_install(name, image, packages):
    commands = ["wget %s --directory-prefix=/tmp/deb" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = commands + ["dpkg -i /tmp/deb/*.deb", "rm /tmp/deb/*.deb"],
        image = image,
    )

# Replace with GitHub releases style command
def zip_download_and_install(name, image, target, package):
    container_run_and_commit(
        name = name,
        commands = [
            "curl -L %s -o /tmp/%s.zip" % (package, name),
            "unzip /tmp/%s.zip -d %s" % (name, target),
            "rm /tmp/%s.zip" % (name),
        ],
        image = image,
    )
