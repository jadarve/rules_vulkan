"""
"""

load("//glsl:toolchain.bzl", "glsl_toolchain")

toolchain_type(
    name = "toolchain_type",
)

#################################################
## LINUX
#################################################

glsl_toolchain(
    name = "on_linux",
    glslc = "@vulkan_linux//:glslc",
    is_windows = False,
)

toolchain(
    name = "glsl_linux_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":on_linux",
    toolchain_type = "@rules_vulkan//glsl:toolchain_type",
)

#################################################
## WINDOWS
#################################################

glsl_toolchain(
    name = "on_windows",
    glslc = "@vulkan_windows//:glslc",
    is_windows = True,
)

toolchain(
    name = "glsl_windows_toolchain",
    exec_compatible_with = [
        "@platforms//os:windows",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":on_windows",
    toolchain_type = "@rules_vulkan//glsl:toolchain_type",
)