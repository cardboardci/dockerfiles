# tag: ubuntu:xenial-20210114
FROM ubuntu@sha256:0eb12402800064cd8f7ae75e9c4ce1a1b5d6b9582bbaf20c539ae19652cc46ec

LABEL "name"="dependencies"
LABEL "maintainer"="Jonathan Beverly <jonathan@jrbeverly.me>"
LABEL "version"="0.0.1"

LABEL "com.github.actions.name"="dependencies"
LABEL "com.github.actions.description"="Upgrade dependencies of a series of Dockerfiles"
LABEL "com.github.actions.icon"="git"
LABEL "com.github.actions.color"="purple"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install --no-install-recommends -y git jq curl ca-certificates wget make \
    # luarocks
    && apt-get install --no-install-recommends -y luarocks lua-sec gcc \ 
    # npm
    && apt-get install --no-install-recommends -y nodejs npm \ 
    # npm
    && apt-get install --no-install-recommends -y python3 python3-pip \ 
    # rubygems
    && apt-get install --no-install-recommends -y ruby ruby-dev bison \ 
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["bash", "/entrypoint.sh"]
