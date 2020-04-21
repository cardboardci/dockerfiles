FROM cardboardci/ci-core@sha256:5b93f4c8cc1ddaa809f9c27d0a865a974ccb43e5e3d38334df1b0d77ea1843fb
USER root

ARG DEBIAN_FRONTEND=noninteractive

ARG VERSION=2.6.0

COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
    && xargs -a /cardboardci/pkglist apt-get install --no-install-recommends -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY provision/binlist /cardboardci/binlist
RUN mkdir -p /tmp/bin/ \
    && xargs -a /cardboardci/binlist -I {} bash -c 'wget $(echo "{}" | cut -d '=' -f1) -O /tmp/bin/$(echo "{}" | cut -d= -f2)' \
    && chmod +x /tmp/bin/* \
    && mv /tmp/bin/* /usr/bin/ \
    && rm -rf tmp/bin

RUN curl -sSL "https://raw.githubusercontent.com/zaquestion/lab/master/install.sh" | bash
USER cardboardci

##
## Image Metadata
##
ARG build_date
ARG version
ARG vcs_ref
LABEL maintainer="CardboardCI"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="gitlab"
LABEL org.label-schema.version="${version}"
LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.release="CardboardCI version:${version} build-date:${build_date}"
LABEL org.label-schema.vendor="cardboardci"
LABEL org.label-schema.architecture="amd64"
LABEL org.label-schema.summary="GitLab CLI"
LABEL org.label-schema.description="Lab wraps Git or Hub, making it simple to clone, fork, and interact with repositories on GitLab"
LABEL org.label-schema.url="https://gitlab.com/cardboardci/images/gitlab"
LABEL org.label-schema.changelog-url="https://gitlab.com/cardboardci/images/gitlab/releases"
LABEL org.label-schema.authoritative-source-url="https://cloud.docker.com/u/cardboardci/repository/docker/cardboardci/gitlab"
LABEL org.label-schema.distribution-scope="public"
LABEL org.label-schema.vcs-type="git"
LABEL org.label-schema.vcs-url="https://gitlab.com/cardboardci/images/gitlab"
LABEL org.label-schema.vcs-ref="${vcs_ref}"