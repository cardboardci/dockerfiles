_TEMPLATE = "//tools/template:Dockerfile.template"

ORG_LABELSCHEMA = {
    "{org_labelschema_maintainer}": "CardboardCI",
    "{org_labelschema_schemaversion}": "1.0",
    "{org_labelschema_vendor}": "cardboardci",
    "{org_labelschema_architecture}": "amd64",
    "{org_labelschema_distributionscope}": "public",
    "{org_labelschema_vcs_type}": "git",
    "{version}": "0.0.0",
    "{vcs_url}": "https://github.com/cardboardci/dockerfiles",
}

COMMON_DIGEST = "sha256:5d7351ea2789b130c4bee518731b51bd7c83bd03bc93d5818d6750835a842a94"

def _ziplist_impl():
    return """
COPY provision/ziplist /cardboardci/ziplist
RUN mkdir -p /tmp/zip \
&& cd /tmp/zip \
&& xargs -a /cardboardci/ziplist curl -sSL -O \
&& unzip /tmp/zip/*.zip -d /usr/bin/ \
&& rm -rf /tmp/zip
"""

def _binlist_impl():
    return """
COPY provision/binlist /cardboardci/binlist
RUN mkdir -p /tmp/bin/ \
&& xargs -a /cardboardci/binlist -I {} bash -c 'wget $(echo "{}" | cut -d '=' -f1) -O /tmp/bin/$(echo "{}" | cut -d= -f2)' \
&& chmod +x /tmp/bin/* \
&& mv /tmp/bin/* /usr/bin/ \
&& rm -rf tmp/bin
"""

def _pkglist_impl():
    return """
COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
&& xargs -a /cardboardci/pkglist apt-get install -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*
"""

def _deblist_impl():
    return """
COPY provision/deblist /cardboardci/deblist
RUN mkdir -p /tmp/deb \
&& xargs -a /cardboardci/deblist wget --directory-prefix=/tmp/deb \
&& dpkg -i /tmp/deb/*.deb \
&& rm -rf tmp/deb
"""

def _nodelist_impl():
    return """
COPY provision/nodelist /cardboardci/nodelist
RUN ( xargs -a /cardboardci/nodelist npm install -g ) || true
"""

def _lualist_impl():
    return """
COPY provision/lualist /cardboardci/lualist
RUN  xargs -a /cardboardci/lualist luarocks install
"""

def _pwshlist_impl():
    return """
COPY provision/lualist /cardboardci/lualist
RUN  xargs -a /cardboardci/lualist luarocks install
"""

def _piplist_impl():
    return """
COPY provision/piplist /cardboardci/piplist
RUN xargs -a /cardboardci/piplist pip3 install
"""

def _gemlist_impl():
    return """
COPY provision/gemlist /cardboardci/gemlist
RUN xargs -a /cardboardci/gemlist gem install
"""

def _install_impl():
    return """
COPY provision/install.sh /tmp/install.sh
RUN bash /tmp/install.sh ; sync ; rm /tmp/install.sh
"""

def _script_impl(cmd):
    return """
RUN %s
""" % cmd

def _dockerfile_impl(ctx):
    installs = {
        "{apt_get}": _pkglist_impl() if 'apt-get' in ctx.attr.packages else '',
        "{dpkg}": _deblist_impl() if 'dpkg' in ctx.attr.packages else '',
        "{npm}": _nodelist_impl() if 'npm' in ctx.attr.packages else '',
        "{bin}": _binlist_impl() if 'bin' in ctx.attr.packages else '',
        "{zip}": _ziplist_impl() if 'zip' in ctx.attr.packages else '',
        "{lua}": _lualist_impl() if 'lua' in ctx.attr.packages else '',
        "{pwsh}": _pwshlist_impl() if 'pwsh' in ctx.attr.packages else '',
        "{pip}": _piplist_impl() if 'pip' in ctx.attr.packages else '',
        "{rubygems}": _gemlist_impl() if 'rubygems' in ctx.attr.packages else '',
        "{install}": _install_impl() if 'install' in ctx.attr.packages else '',
        "{script}": _script_impl(ctx.attr.script) if ctx.attr.script else '',
    }

    inputs = {
        "{digest}": ctx.attr.digest,
        "{org_labelschema_name}": ctx.attr.image,
    }
    arguments = dict(inputs, **installs)

    schema = dict(ORG_LABELSCHEMA, **ctx.attr.label_schema)

    subs = dict(schema, **arguments)
    ctx.actions.expand_template(
        template = ctx.file._template,
        output = ctx.outputs.source_file,
        substitutions = subs,
    )

dockerfile = rule(
    implementation = _dockerfile_impl,
    attrs = {
        "image": attr.string(mandatory = True),
        "digest": attr.string(mandatory = True),
        "packages": attr.string_list(mandatory = True),
        "script": attr.string(),
        "label_schema": attr.string_dict(mandatory = True),
        "_template": attr.label(
            default = Label(_TEMPLATE),
            allow_single_file = True,
        ),
    },
    outputs = {"source_file": "Dockerfile"},
)