ARG DIGEST=sha256:3f5fbe4b658d8cd3b7009947d1de44ca6e7fd1d25fc6723637bf5d6ab01db0c4
FROM cardboardci/base@${DIGEST}
USER root

ARG DEBIAN_FRONTEND=noninteractive

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install --no-install-recommends -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/deblist /cardboardci/deblist
RUN mkdir -p /tmp/deb \
    && xargs -a /cardboardci/deblist wget --directory-prefix=/tmp/deb \
    && dpkg -i /tmp/deb/*.deb \
    && rm -rf /tmp/zip

USER cardboardci

##
## Image Metadata
##
ARG build_date
ARG version
ARG vcs_ref
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="github"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.release="CardboardCI version:${version} build-date:${build_date}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="GitHub CLI"
LABEL org.label-schema.description="A command-line tool that makes git easier to use with GitHub"
LABEL org.label-schema.url="https://gitlab.com/cardboardci/images/github"
LABEL org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/github/releases"
LABEL org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/github"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://gitlab.com/cardboardci/images/github"
LABEL org.label-schema.vcs-ref="${vcs_ref}"