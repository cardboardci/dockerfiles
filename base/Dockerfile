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
ENTRYPOINT [ "/bin/bash", "-l", "-c" ]

ARG version=1.0.0
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="ci-core"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.release="CardboardCI version:${version}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="Base image for CI"
LABEL org.label-schema.description="Base image for CI."
LABEL org.label-schema.url="https://github.com/cardboardci/docker-ci-core"
LABEL org.label-schema.changelog-url="https://github.com/cardboardci/docker-ci-core/releases"
LABEL org.label-schema.authoritative-source-url="https://hub.docker.com/r/cardboardci/ci-core"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://github.com/cardboardci/docker-ci-core"