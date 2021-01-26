# tag: ubuntu:xenial-20210114
FROM ubuntu@sha256:edf232ee7dc18c57c063bc83533ef2c03c6dfae55a0124f7d372aed51cd1d9c8

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
