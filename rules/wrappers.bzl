"""
A collection of wrappers for installing from package managers.
"""

load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")

CARDBOARDCI_UID = "180000"
CARDBOARDCI_GID = "180000"

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
