load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "gitlab",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'bin'],
    script = "curl -sSL 'https://raw.githubusercontent.com/zaquestion/lab/master/install.sh' -o /tmp/install.sh && sync && bash /tmp/install.sh",
    label_schema = {
        "{summary}" : "GitLab CLI",
        "{description}" : "Lab wraps Git or Hub, making it simple to clone, fork, and interact with repositories on GitLab",
    }
)
