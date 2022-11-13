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
)

toolchain(
    name = "glsl_linux_toolchain",
    exec_compatible_with = [
        "@platforms//os:linux",
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

#################################################
## MACOS
#################################################

glsl_toolchain(
    name = "on_macos",
    glslc = "@vulkan_macos//:glslc",
)

toolchain(
    name = "glsl_macos_toolchain",
    exec_compatible_with = [
        "@platforms//os:macos",
        "@platforms//cpu:x86_64",
    ],
    toolchain = ":on_macos",
    toolchain_type = "@rules_vulkan//glsl:toolchain_type",
)
