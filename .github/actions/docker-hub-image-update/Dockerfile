FROM ubuntu:latest

LABEL "name"="docker-hub-image-update"
LABEL "maintainer"="Jonathan Beverly <jonathan@jrbeverly.me>"
LABEL "version"="0.0.1"

LABEL "com.github.actions.name"="Update the base image"
LABEL "com.github.actions.description"="Updates the base image"
LABEL "com.github.actions.icon"="git"
LABEL "com.github.actions.color"="purple"

RUN apt-get update \
    && apt-get install --no-install-recommends -y jq curl ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
