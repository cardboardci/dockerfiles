ARG DIGEST=sha256:3f5fbe4b658d8cd3b7009947d1de44ca6e7fd1d25fc6723637bf5d6ab01db0c4
FROM cardboardci/base@${DIGEST}
USER root

ARG DEBIAN_FRONTEND=noninteractive

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install --no-install-recommends -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/nodelist /cardboardci/nodelist
RUN ( xargs -a /cardboardci/nodelist npm install -g ) || true

COPY rootfs/ /


USER cardboardci

##
## Image Metadata
##
ARG build_date
ARG version
ARG vcs_ref
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="bats"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.release="CardboardCI version:${version} build-date:${build_date}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="Bash Automated Testing System"
LABEL org.label-schema.description="Bats is most useful when testing software written in Bash, but you can use it to test any UNIX program"
LABEL org.label-schema.url="https://gitlab.com/cardboardci/images/bats"
LABEL org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/bats/releases"
LABEL org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/bats"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://gitlab.com/cardboardci/images/bats"
LABEL org.label-schema.vcs-ref="${vcs_ref}"