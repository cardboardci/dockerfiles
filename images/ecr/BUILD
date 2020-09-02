load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "ecr",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "AWS ECR",
        "{description}" : "A unified tool to deploy Docker images to Amazon Elastic Container Registry (ECR)",
    }
)
