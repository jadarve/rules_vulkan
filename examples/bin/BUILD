load("@rules_cc//cc:defs.bzl", "cc_binary")


cc_binary(
    name = "list_extensions",
    srcs = [
        "list_extensions.cpp"
    ],
    linkopts = select({
        "//:linux": [
            "-lvulkan",
        ],
        "//:windows": [],
    }),
    deps = select({
        "//:windows": [
            "@vulkan_windows//:vulkan_cc_library",
        ],
        "//conditions:default": [],
    }),
    visibility = ["//visibility:public"]
)
