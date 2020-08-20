ARG DIGEST=sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2
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
ARG VCS_REF
ARG IMAGE_NAME=cardboardci/wkhtmltopdf:${VERSION}
LABEL maintainer="CardboardCI" \
    \
    readme.md="https://github.com/cardboardci/docker-wkhtmltopdf/blob/master/README.md" \
    description="wkhtmltopdf is a command line tools to render HTML into PDF" \
    \
    org.label-schema.schema-version="1.0" \
    \
    org.label-schema.name="wkhtmltopdf" \
    org.label-schema.version=${VERSION} \
    org.label-schema.release="CardboardCI version:${version}" \
    org.label-schema.vendor="CardboardCI" \
    org.label-schema.architecture="amd64" \
    org.label-schema.usage="https://github.com/cardboardci/docker-wkhtmltopdf/blob/master/README.md#Usage" \
    \
    org.label-schema.summary="Render HTML into PDFs" \
    org.label-schema.description="wkhtmltopdf is a command line tools to render HTML into PDF" \
    \
    org.label-schema.url="https://github.com/cardboardci/docker-wkhtmltopdf/blob/master/README.md" \
    org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/wkhtmltopdf/releases" \
    org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/wkhtmltopdf" \
    org.label-schema.distribution-scope="public" \
    \
    org.label-schema.docker.cmd="docker run ${IMAGE_NAME} pwsh -c '$psversiontable'" \
    org.label-schema.docker.cmd.devel="docker run ${IMAGE_NAME}" \
    org.label-schema.docker.cmd.test="docker run ${IMAGE_NAME} pwsh -c Invoke-Pester" \
    org.label-schema.docker.cmd.help="docker run ${IMAGE_NAME} pwsh -c Get-Help" \
    \
    org.label-schema.vcs-type="git" \
    org.label-schema.vcs-url="https://github.com/cardboardci/docker-wkhtmltopdf" \
    org.label-schema.vcs-ref=${VCS_REF}
