"""
"""

GlslInfo = provider(fields=[
    "includes",
    "headers"
])

def _glsl_header_library(ctx):

    strip_include_prefix = ctx.attr.strip_include_prefix

    includes = dict()

    # Add each header file directory to the includes
    if len(strip_include_prefix) == 0:
        for hdr in ctx.files.hdrs:
            includes[hdr.dirname] = True

    else:
        for hdr in ctx.files.hdrs:

            # check if the header is being included from the lluvia repo
            # or externally (e.g., mediapipe). For external inclusion, bazel
            # adds a "external/lluvia" path to all files of this repo, so I
            # need to include that path as part of the strip_include_prefix

            prefix_index = hdr.dirname.rfind(strip_include_prefix)
            if prefix_index >= 0:
                strip_include_prefix_full = hdr.dirname[:prefix_index] + strip_include_prefix
                includes[strip_include_prefix_full] = True

            else:
                fail("strip_include_prefix \"{0}\" not found in header \"{1}\" path.".format(
                    strip_include_prefix, hdr.path))

    runfiles = ctx.runfiles(files=ctx.files.hdrs)
    default_files = depset(direct=ctx.files.hdrs)

    return [
        GlslInfo(
            headers=depset(direct=ctx.files.hdrs),
            includes=depset(direct=includes.keys())
        ),
        DefaultInfo(files=default_files, runfiles=runfiles)
    ]

def _glsl_shader(ctx):

    toolchain = ctx.toolchains["@rules_vulkan//glsl:toolchain_type"]

    shader = ctx.file.shader

    spirv_name = shader.basename + ".spv"

    spirv = ctx.actions.declare_file(spirv_name, sibling=shader)

    args = ctx.actions.args()
    inputs = [shader]

    for dep in ctx.attr.deps:

        for inc in dep[GlslInfo].includes.to_list():
            args.add("-I", inc)

        # add each header as an input file for the command.
        # This mounts the header into the sandbox running glslc and makes it
        # accessible to the compiler
        for hdr in dep[GlslInfo].headers.to_list():
            inputs.append(hdr)


    args.add("-o", spirv)
    args.add(shader.path)

    if toolchain.is_windows:
        ctx.actions.run(
            inputs = inputs,
            outputs = [spirv],
            arguments = [args],
            executable = toolchain.glslc_executable,
            progress_message = "compiling GLSL",
            mnemonic = 'GLSLC'
        )
    else:
        # ctx.actions.run(
        #     inputs = inputs,
        #     outputs = [spirv],
        #     arguments = [args],
        #     executable = toolchain.glslc_executable,
        #     progress_message = "compiling GLSL",
        #     mnemonic = 'GLSLC'
        # )
        # FIXME: using ctx.actions.run with toolchain.glslc_executable
        #        does not work in Linux.
        ctx.actions.run_shell(
            inputs = inputs,
            outputs = [spirv],
            arguments = [args],
            command = "{0} $@".format(toolchain.glslc_executable),
            progress_message = "compiling GLSL",
            mnemonic = 'GLSLC'
        )

    runfiles = ctx.runfiles(
        files = [spirv]
    )

    default_files = depset(direct=[spirv])

    return [
        DefaultInfo(files=default_files, runfiles=runfiles)
    ]

glsl_header_library = rule(
    implementation = _glsl_header_library,
    attrs = {
        "hdrs": attr.label_list(allow_files=[".glsl"]),
        "strip_include_prefix": attr.string(default=""),
    },
    provides = [DefaultInfo, GlslInfo]
)

glsl_shader = rule(
    implementation = _glsl_shader,
    attrs = {
        "shader": attr.label(allow_single_file=[".vert", ".frag", ".tesc", ".tese", ".geom", ".comp"]),
        "deps": attr.label_list(providers=[GlslInfo]),
    },
    toolchains = ["@rules_vulkan//glsl:toolchain_type"],
    provides = [DefaultInfo]
)
