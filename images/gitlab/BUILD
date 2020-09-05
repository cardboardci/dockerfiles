load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "gitlab",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'bin'],
    script = "curl -sSL 'https://raw.githubusercontent.com/zaquestion/lab/master/install.sh' -o /tmp/install.sh && sync && bash /tmp/install.sh",
    label_schema = {
        "{summary}" : "GitLab CLI",
        "{description}" : "Lab wraps Git or Hub, making it simple to clone, fork, and interact with repositories on GitLab",
    }
)
