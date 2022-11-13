load("@rules_cc//cc:defs.bzl", "cc_library")

VULKAN_LINKOPTS = select({
    "@rules_vulkan//:linux": ["-lvulkan"],
    "@rules_vulkan//:android": [],
    "@rules_vulkan//:windows": [],
    "@rules_vulkan//:darwin": [],
    "//conditions:default": [],
})

VULKAN_LIBRARIES = select(
    {
        "@rules_vulkan//:windows": ["@vulkan_windows//:vulkan_cc_library"],
        "@rules_vulkan//:darwin": ["@vulkan_macos//:vulkan_cc_library"],
        "@rules_vulkan//:linux": ["@vulkan_linux//:vulkan_cc_library"],
        "@rules_vulkan//:android": ["@vulkan_android//:vulkan_cc_library"],
    },
    no_match_error = "No configuration matches the supported platforms",
)

cc_library(
    name = "vulkan_cc_library",
    linkopts = VULKAN_LINKOPTS,
    visibility = ["//visibility:public"],
    deps = VULKAN_LIBRARIES,
)
