load("@rules_cc//cc:defs.bzl", "cc_library")
load("defs.bzl", "VULKAN_LIBRARIES", "VULKAN_LINKOPTS")

cc_library(
    name = "sdk",
    linkopts = VULKAN_LINKOPTS,
    visibility = ["//visibility:public"],
    deps = VULKAN_LIBRARIES,
)
