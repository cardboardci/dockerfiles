load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "bats",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "Bash Automated Testing System",
        "{description}" : "Bats is most useful when testing software written in Bash, but you can use it to test any UNIX program",
    }
)
