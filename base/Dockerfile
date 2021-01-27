# tag: ubuntu:xenial-20210114
FROM ubuntu@sha256:edf232ee7dc18c57c063bc83533ef2c03c6dfae55a0124f7d372aed51cd1d9c8
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

USER ${USER}
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