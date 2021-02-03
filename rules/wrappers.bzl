load("@io_bazel_rules_docker//docker/util:run.bzl", "container_run_and_commit")

def luacheck_download_and_install(name, image, packages):
    commands = ["luarocks install %s" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = commands,
        image = image,
    )

def npm_download_and_install(name, image, packages):
    commands = ["npm install -y %s" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = commands,
        image = image,
    )

def deb_download_and_install(name, image, packages):
    commands = ["wget %s --directory-prefix=/tmp/deb" % p for p in packages]
    container_run_and_commit(
        name = name,
        commands = commands + ["dpkg -i /tmp/deb/*.deb", "rm /tmp/deb/*.deb"],
        image = image,
    )
