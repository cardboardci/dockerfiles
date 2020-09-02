load("//tools/template:docker-file.bzl", "dockerfile")

dockerfile(
    name = "dockerfile",
    image = "psscriptanalyzer",
    digest = "sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2",
    packages = ['apt-get', 'dpkg'],
    script = "mkdir -p /home/cardboardci/.local/share/powershell/ && chown -R cardboardci:cardboardci /home/cardboardci/ /opt/microsoft/",
    label_schema = {
        "{summary}" : "Powershell linter",
        "{description}" : "PSScriptAnalyzer is a static code checker for Windows PowerShell modules and scripts",
    }
)
