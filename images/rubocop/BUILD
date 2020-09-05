load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "rubocop",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'rubygems'],
    label_schema = {
        "{summary}" : "Ruby static code analyzer",
        "{description}" : "A Ruby static code analyzer and formatter, based on the community Ruby style guide",
    }
)
