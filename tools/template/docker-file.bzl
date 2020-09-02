_TEMPLATE = "//tools/template:Dockerfile.template"

ORG_LABELSCHEMA = {
    "{org_labelschema_maintainer}": "CardboardCI",
    "{org_labelschema_schemaversion}": "1.0",
    "{org_labelschema_vendor}": "cardboardci",
    "{org_labelschema_architecture}": "amd64",
    "{org_labelschema_distributionscope}": "public",
    "{org_labelschema_vcs_type}": "git",
}

def _dockerfile_impl(ctx):
    inputs = {
        "{builddate}": ctx.attr.digest,
        "{version}": ctx.attr.digest,
        "{vcs_ref}": ctx.attr.digest,
        "{digest}": ctx.attr.digest,
        "{vcs_url}": ctx.attr.vcs_url,
        "{org_labelschema_name}": ctx.attr.name,
    }
    subs = dict(ORG_LABELSCHEMA, **inputs)
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
        "summary": attr.string(mandatory = True),
        "description": attr.string(mandatory = True),
        "label_schema": attr.string_dict(mandatory = True),
        "_template": attr.label(
            default = Label(_TEMPLATE),
            allow_single_file = True,
        ),
    },
    outputs = {"source_file": "%{name}.dockerfile"},
)