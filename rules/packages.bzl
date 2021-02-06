"""
Rules for representing package from package managers.
"""

_PACKAGE_JSON_TEMPLATE = "\"package\": \"{package}\", \"version\": \"{version}\", \"sum\": \"{sum}\""

def _package_json_impl(ctx):
    ctx.actions.write(
        output = ctx.outputs.manifest,
        content = "{" + _PACKAGE_JSON_TEMPLATE.format(
            package = ctx.attr.package,
            version = ctx.attr.version,
            sum = ctx.attr.sum,
        ) + "}",
    )

package_json = rule(
    implementation = _package_json_impl,
    attrs = {
        "package": attr.string(mandatory = True),
        "version": attr.string(mandatory = True),
        "sum": attr.string(mandatory = True),
    },
    outputs = {"manifest": "%{name}.json"},
)
