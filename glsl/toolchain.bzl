"""The GLSL toolchain definition and implementation
"""

def _glsl_toolchain_impl(ctx):

    # it is expected the the glslc target contains one and only one
    # file that is the compiler.
    glslc_executable = ctx.attr.glslc.files.to_list()[0].path

    toolchain_info = platform_common.ToolchainInfo(
        glslc = ctx.attr.glslc,
        glslc_executable = glslc_executable,
        is_windows = ctx.attr.is_windows,
    )

    return [toolchain_info]


glsl_toolchain = rule(
    implementation = _glsl_toolchain_impl,
    attrs = {
        "glslc": attr.label(
            doc = "The location of the glslc compiler.",
            allow_single_file = True
        ),
        "is_windows": attr.bool(
            doc = "Whether or not this toolchain runs in windows",
            mandatory = True
        )
    },
)
