"""A macro to configure Vulkan SDK deps"""

load("@rules_cc//cc:defs.bzl", "cc_library")

VULKAN_LINKOPTS = select({
    "@bazel_tools//src/conditions:linux_x86_64": ["-lvulkan"],
    "//conditions:default": [],
})

VULKAN_LIBRARIES = select({
    "@bazel_tools//src/conditions:windows": ["@vulkan_windows//:vulkan_cc_library"],
    "@bazel_tools//src/conditions:darwin": ["@vulkan_macos//:vulkan_cc_library"],
    "//conditions:default": [],
})

def vulkan_sdk():
    """Defines the Vulkan SDK targets with proper exported headers and linkopts.

        The targets will be of the form ":<artifact-id>".
    """

    cc_library(
        name = "vulkan",
        deps = VULKAN_LIBRARIES,
        linkopts = VULKAN_LINKOPTS,
        visibility = ["//visibility:public"],
    )
