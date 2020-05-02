ARG DIGEST=sha256:3f5fbe4b658d8cd3b7009947d1de44ca6e7fd1d25fc6723637bf5d6ab01db0c4
FROM cardboardci/base@${DIGEST}
USER root

ARG DEBIAN_FRONTEND=noninteractive

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/binlist /cardboardci/binlist
RUN mkdir -p /tmp/bin/ \
    && xargs -a /cardboardci/binlist -I {} bash -c 'wget $(echo "{}" | cut -d '=' -f1) -O /tmp/bin/$(echo "{}" | cut -d= -f2)' \
    && chmod +x /tmp/bin/* \
    && mv /tmp/bin/* /usr/bin/ \
    && rm -rf tmp/bin

USER cardboardci

##
## Image Metadata
##
ARG build_date
ARG version
ARG vcs_ref
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="hadolint"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.release="CardboardCI version:${version} build-date:${build_date}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="Dockerfile linter"
LABEL org.label-schema.description="Dockerfile linter, validate inline bash, written in Haskell"
LABEL org.label-schema.url="https://gitlab.com/cardboardci/images/hadolint"
LABEL org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/hadolint/releases"
LABEL org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/hadolint"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://gitlab.com/cardboardci/images/hadolint"
LABEL org.label-schema.vcs-ref="${vcs_ref}"
