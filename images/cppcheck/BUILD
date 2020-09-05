load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "cppcheck",
    digest = COMMON_DIGEST,
    packages = ['apt-get'],
    label_schema = {
        "{summary}" : "C++ linter",
        "{description}" : "Static analysis of C/C++ code",
    }
)
