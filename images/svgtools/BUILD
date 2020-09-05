load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "svgtools",
    digest = COMMON_DIGEST,
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "Rasterize SVGs",
        "{description}" : "Tools for working with Scalable Vector Graphics (SVG) files",
    }
)
