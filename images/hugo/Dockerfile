FROM cardboardci/ci-core@sha256:5b93f4c8cc1ddaa809f9c27d0a865a974ccb43e5e3d38334df1b0d77ea1843fb
USER root

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/deblist /cardboardci/deblist
RUN mkdir -p /tmp/deb \
    && xargs -a /cardboardci/deblist wget --directory-prefix=/tmp/deb \
    && dpkg -i /tmp/deb/*.deb \
    && rm -rf tmp/deb

USER cardboardci

##
## Image Metadata
##
ARG build_date
ARG version
ARG vcs_ref
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="hugo"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.release="CardboardCI version:${version} build-date:${build_date}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="Hugo static site generator"
LABEL org.label-schema.description=" Hugo is an open-source static site generator"
LABEL org.label-schema.url="https://gitlab.com/cardboardci/images/hugo"
LABEL org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/hugo/releases"
LABEL org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/hugo"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://gitlab.com/cardboardci/images/hugo"
LABEL org.label-schema.vcs-ref="${vcs_ref}"
