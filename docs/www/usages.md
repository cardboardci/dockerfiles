# Using the containers

## Intro

Continuous Integration services typically offer the ability to run commands in docker containers, with the exact image specified through YAML configurations. You can see this with services like GitHub Actions, CircleCI, or GitLabCI.

A recommended approach is to either build the images in a forked repository, or to make use of a mirroring system for ensuring maximum availability of the images in continuous integration.

The following is an example of an image running in GitHub Actions:

```yml
# GitHub Actions
jobs:
    my_first_job:
        steps:
            - name: My first step
              uses: docker://ghcr.io/cardboardci/awscli:edge
              with:
                  args: "aws --version"
```

## Image Structure

All of the images have `/workspace` set as the default working directory, and expect this to be the mounting point for local testing. Any continuous integration service will likely override this, but should ensure the permissions are correctly set.

The aim with `/workspace` is to ensure that any examples, snippets or dotfiles can assume that this directory will be correctly configured as a mount point for running utilities.
