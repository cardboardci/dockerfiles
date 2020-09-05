load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "netlify",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'npm'],
    label_schema = {
        "{summary}" : "Netlify CLI",
        "{description}" : "Netlify builds, deploys and hosts your netlify services",
    }
)
