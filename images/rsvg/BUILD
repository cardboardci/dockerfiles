load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "rsvg",
    digest = COMMON_DIGEST,
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "Rasterize SVGs",
        "{description}" : "Turn SVG files into raster images",
    }
)
