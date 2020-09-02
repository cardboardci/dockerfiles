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
        "{summary}": ctx.attr.summary,
        "{description}": ctx.attr.description,
        "{version}": ctx.attr.version,
        "{digest}": ctx.attr.digest,
        "{vcs_url}": ctx.attr.vcs_url,
        "{org_labelschema_name}": ctx.attr.name,
    }
    schema = dict(ORG_LABELSCHEMA, **ctx.attr.label_schema)
    subs = dict(schema, **inputs)
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
        "version": attr.string(mandatory = True),
        "label_schema": attr.string_dict(mandatory = True),
        "_template": attr.label(
            default = Label(_TEMPLATE),
            allow_single_file = True,
        ),
    },
    outputs = {"source_file": "%{name}.dockerfile"},
)