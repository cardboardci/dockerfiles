_TEMPLATE = "//tools/template:Dockerfile.template"

ORG_LABELSCHEMA = {
    "{org_labelschema_maintainer}": "CardboardCI",
    "{org_labelschema_schemaversion}": "1.0",
    "{org_labelschema_vendor}": "cardboardci",
    "{org_labelschema_architecture}": "amd64",
    "{org_labelschema_distributionscope}": "public",
    "{org_labelschema_vcs_type}": "git",
}

def _pkglist_impl():
    return """COPY provision/pkglist /cardboardci/pkglist
RUN apt-get update \
&& xargs -a /cardboardci/pkglist apt-get install -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*"""

def _deblist_impl():
    return """COPY provision/deblist /cardboardci/deblist
RUN mkdir -p /tmp/deb \
&& xargs -a /cardboardci/deblist wget --directory-prefix=/tmp/deb \
&& dpkg -i /tmp/deb/*.deb \
&& rm -rf tmp/deb"""

def _nodelist_impl():
    return """COPY provision/nodelist /cardboardci/nodelist
RUN ( xargs -a /cardboardci/nodelist npm install -g ) || true"""

def _dockerfile_impl(ctx):
    installs = {
        "{apt_get}": _pkglist_impl() if 'apt-get' in ctx.attr.packages else '',
        "{dpkg}": _deblist_impl() if 'dpkg' in ctx.attr.packages else '',
        "{npm}": _nodelist_impl() if 'npm' in ctx.attr.packages else '',
    }

    inputs = {
        "{version}": ctx.attr.version,
        "{digest}": ctx.attr.digest,
        "{vcs_url}": ctx.attr.vcs_url,
        "{org_labelschema_name}": ctx.attr.name,
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
        "digest": attr.string(mandatory = True),
        "vcs_url": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
        "packages": attr.string_list(mandatory = True),
        "label_schema": attr.string_dict(mandatory = True),
        "_template": attr.label(
            default = Label(_TEMPLATE),
            allow_single_file = True,
        ),
    },
    outputs = {"source_file": "%{name}.dockerfile"},
)