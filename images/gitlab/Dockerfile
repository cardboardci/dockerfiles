ARG DIGEST=sha256:2a0ca344b220f3e922bcca6136f585697573b74bb6f69115a5b152dbfe68bad2
FROM cardboardci/base@${DIGEST}
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

RUN curl -sSL "https://raw.githubusercontent.com/zaquestion/lab/master/install.sh" -o /tmp/install.sh && sync && bash /tmp/install.sh
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