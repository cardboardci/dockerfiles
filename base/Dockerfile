# tag: ubuntu:focal-20210119
FROM ubuntu@sha256:3093096ee188f8ff4531949b8f6115af4747ec1c58858c091c8cb4579c39cc4e
ARG DEBIAN_FRONTEND=noninteractive
ARG USER=cardboardci

RUN apt-get update \ 
    && apt-get upgrade -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install --no-install-recommends -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/user.sh /cardboardci/user.sh
RUN bash /cardboardci/user.sh ; sync ; rm -f /cardboardci/user.sh

WORKDIR /cardboardci/workspace

ARG version=1.0.0
LABEL maintainer="CardboardCI"
LABEL org.opencontainers.image.title="ci-core"
LABEL org.opencontainers.image.version="${version}"
LABEL org.opencontainers.image.release="CardboardCI version:${version}"
LABEL org.opencontainers.image.vendor="cardboardci"
LABEL org.opencontainers.image.architecture="amd64"
LABEL org.opencontainers.image.summary="Base image for CI"
LABEL org.opencontainers.image.description="Base image for CI."
LABEL org.opencontainers.image.url="https://github.com/cardboardci/docker-ci-core"
LABEL org.opencontainers.image.changelog-url="https://github.com/cardboardci/docker-ci-core/releases"
LABEL org.opencontainers.image.authoritative-source-url="https://hub.docker.com/r/cardboardci/ci-core"
LABEL org.opencontainers.image.distribution-scope="public"
LABEL org.opencontainers.image.vcs-type="git"
LABEL org.opencontainers.image.source="https://github.com/cardboardci/dockerfiles/base"