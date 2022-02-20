load("@rules_cc//cc:defs.bzl", "cc_library")

VULKAN_LINKOPTS = select({
    "@platforms//os:linux": ["-lvulkan"],
    "//conditions:default": [],
})

VULKAN_LIBRARIES = select({
    "@bazel_tools//src/conditions:windows": ["@vulkan_windows//:vulkan_cc_library"],
    "@bazel_tools//src/conditions:darwin": ["@vulkan_macos//:vulkan_cc_library"],
    "//conditions:default": [],
})

cc_library(
    name = "vulkan_cc_library",
    linkopts = VULKAN_LINKOPTS,
    visibility = ["//visibility:public"],
    deps = VULKAN_LIBRARIES,
)
