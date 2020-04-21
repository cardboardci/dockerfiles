FROM cardboardci/ci-core@sha256:b3e7917c28200c780e0e6a19057cb546fcafc4719640f6b8be459c390714f97c
USER root

ARG DEBIAN_FRONTEND=noninteractive

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install --no-install-recommends -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/install.sh /tmp/install.sh
RUN bash /tmp/install.sh ; sync ; rm /tmp/install.sh

USER cardboardci

##
## Image Metadata
##
ARG build_date
ARG version
ARG vcs_ref
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="pdf2htmlex"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.release="CardboardCI version:${version} build-date:${build_date}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="PDF 2 HTML"
LABEL org.label-schema.description="Convert PDF to HTML without losing text or format"
LABEL org.label-schema.url="https://gitlab.com/cardboardci/images/pdf2htmlex"
LABEL org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/pdf2htmlex/releases"
LABEL org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/pdf2htmlex"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://gitlab.com/cardboardci/images/pdf2htmlex"
LABEL org.label-schema.vcs-ref="${vcs_ref}"