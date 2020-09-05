load("//tools/template:docker-file.bzl", "dockerfile", "COMMON_DIGEST")

dockerfile(
    name = "dockerfile",
    image = "psscriptanalyzer",
    digest = COMMON_DIGEST,
    packages = ['apt-get', 'dpkg'],
    script = "mkdir -p /home/cardboardci/.local/share/powershell/ && chown -R cardboardci:cardboardci /home/cardboardci/ /opt/microsoft/",
    label_schema = {
        "{summary}" : "Powershell linter",
        "{description}" : "PSScriptAnalyzer is a static code checker for Windows PowerShell modules and scripts",
    }
)
