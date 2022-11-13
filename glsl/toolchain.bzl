"""The GLSL toolchain definition and implementation
"""

def _glsl_toolchain_impl(ctx):
    """
    GLSL toolchain implementation
    """

    glslc_executable = ctx.executable.glslc

    toolchain_info = platform_common.ToolchainInfo(
        glslc = ctx.attr.glslc,
        glslc_executable = glslc_executable,
    )

    return [toolchain_info]

glsl_toolchain = rule(
    implementation = _glsl_toolchain_impl,
    attrs = {
        "glslc": attr.label(
            doc = "The location of the glslc compiler.",
            executable = True,
            cfg = "exec",
            allow_single_file = True,
            mandatory = True,
        ),
    },
)
