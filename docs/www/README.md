# Introduction

CardboardCI is a collection of several Docker images intended to be used for continuous integration. All of the images are pre-built and made available through the GitHub Container Registry, but built with the intentions to be usable to with any registry. These images are intended to upgrade automatically and enforce a series of constraints to ensure that they all behave similarly.

## Intentions

The images in this organization were built with efficiency, caching and determinism in mind. They are built using Bazel, with a base image responsible for ensuring core depdendencies are included in all images. The images are intended to be upgraded automatically when dependency upgrades are detected. These will raise a pull request, and automatically merge if the pull request successfully completes the checks.

## Images

| IMAGE NAME                                                  | DESCRIPTION                                                                                            |
| ----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| [**cardboardci/base**](images/base)                         | A base image with common dependencies for CI environments                                              |
| [**cardboardci/awscli**](images/awscli)                     | The AWS Command Line Interface (CLI) is a unified tool to manage your AWS services                     |
| [**cardboardci/bats**](images/bats)                         | Bats is most useful when testing software written in Bash, but you can use it to test any UNIX program |
| [**cardboardci/cppcheck**](images/cppcheck)                 | Static analysis of C/C++ code                                                                          |
| [**cardboardci/dbxcli**](images/dbxcli)                     | A command line client for Dropbox built using the Go SDK.                                              |
| [**cardboardci/ecr**](images/ecr)                           | A unified tool to deploy Docker images to Amazon Elastic Container Registry (ECR)                      |
| [**cardboardci/github**](images/github)                     | A command-line tool that makes git easier to use with GitHub                                           |
| [**cardboardci/gitlab**](images/gitlab)                     | Lab wraps Git or Hub, making it simple to clone, fork, and interact with repositories on GitLab        |
| [**cardboardci/hadolint**](images/hadolint)                 | Dockerfile linter, validate inline bash, written in Haskell                                            |
| [**cardboardci/htmlhint**](images/htmlhint)                 | The static code analysis tool you need for your HTML                                                   |
| [**cardboardci/hugo**](images/hugo)                         | Hugo is an open-source static site generator                                                           |
| [**cardboardci/luacheck**](images/luacheck)                 | Luacheck is a static analyzer and a linter for Lua                                                     |
| [**cardboardci/markdownlint**](images/markdownlint)         | A Node.js style checker and lint tool for Markdown/CommonMark files                                    |
| [**cardboardci/netlify**](images/netlify)                   | Netlify builds, deploys and hosts your netlify services                                                |
| [**cardboardci/pdf2htmlex**](images/pdf2htmlex)             | Convert PDF to HTML without losing text or format                                                      |
| [**cardboardci/pdftools**](images/pdftools)                 | Command line tools for manipulating pdfs                                                               |
| [**cardboardci/psscriptanalyzer**](images/psscriptanalyzer) | PSScriptAnalyzer is a static code checker for Windows PowerShell modules and scripts                   |
| [**cardboardci/pylint**](images/pylint)                     | Pylint is a Python static code analysis tool which looks for programming errors                        |
| [**cardboardci/rsvg**](images/rsvg)                         | Turn SVG files into raster images                                                                      |
| [**cardboardci/rubocop**](images/rubocop)                   | A Ruby static code analyzer and formatter, based on the community Ruby style guide                     |
| [**cardboardci/shellcheck**](images/shellcheck)             | ShellCheck is a static anaylsis tool that automatically finds bugs in your shell scripts               |
| [**cardboardci/stylelint**](images/stylelint)               | A mighty, modern style linter                                                                          |
| [**cardboardci/surge**](images/surge)                       | Surge is static web publishing for Front-End Developers, right from the CLI                            |
| [**cardboardci/svgtools**](images/svgtools)                 | Tools for working with Scalable Vector Graphics (SVG) files                                            |
| [**cardboardci/tflint**](images/tflint)                     | TFLint is a Terraform linter for detecting errors that can not be detected by terraform plan           |
| [**cardboardci/wkhtmltopdf**](images/wkhtmltopdf)           | wkhtmltopdf is a command line tools to render HTML into PDF                                            |
