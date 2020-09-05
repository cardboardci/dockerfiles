load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "ecr",
    digest = COMMON_DIGEST,
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "AWS ECR",
        "{description}" : "A unified tool to deploy Docker images to Amazon Elastic Container Registry (ECR)",
    }
)
