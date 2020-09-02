load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "rubocop",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'rubygems'],
    label_schema = {
        "{summary}" : "Ruby static code analyzer",
        "{description}" : "A Ruby static code analyzer and formatter, based on the community Ruby style guide",
    }
)
