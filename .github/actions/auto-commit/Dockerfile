FROM ubuntu:focal-20191030

LABEL "name"="auto-commit"
LABEL "maintainer"="Jonathan Beverly <jonathan@jrbeverly.me>"
LABEL "version"="0.0.1"

LABEL "com.github.actions.name"="Auto-commit for GitHub Actions"
LABEL "com.github.actions.description"="Commits and raises a pull request for the changes"
LABEL "com.github.actions.icon"="git"
LABEL "com.github.actions.color"="purple"

RUN apt-get update \
    && apt-get install --no-install-recommends -y git jq curl ca-certificates wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O hub.tgz "https://github.com/github/hub/releases/download/v2.12.8/hub-linux-amd64-2.12.8.tgz" \
    && tar -xvf hub.tgz --strip-components 1 -C /usr/local;

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
