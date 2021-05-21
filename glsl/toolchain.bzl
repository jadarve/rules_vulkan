"""The GLSL toolchain definition and implementation
"""

def _glsl_toolchain_impl(ctx):

    toolchain_info = platform_common.ToolchainInfo(
        glslc = ctx.attr.glslc
    )

    return [toolchain_info]


glsl_toolchain = rule(
    implementation = _glsl_toolchain_impl,
    attrs = {
        "glslc": attr.string(
            doc = "The location of the glslc compiler",
            # allow_single_file = True
        ),
    },
)
