
# See https://github.com/bazelbuild/bazel/blob/master/src/conditions/BUILD for standard conditions.
# Unfortunately, there is no one for android at the moment.

config_setting (
    name = "linux",
    constraint_values = [
        "@platforms//os:linux",
    ],
    visibility = ["//visibility:public"]
)

config_setting (
    name = "android",
    # constraint_values = [
    #     # Does not work with mediapipe 
    #     "@platforms//os:android",
    # ],
    values = {
        "define": "RULES_VULKAN_ANDROID=1"
    },
    visibility = ["//visibility:public"]
)

config_setting(
    name = "windows",
    constraint_values = ["@platforms//os:windows"],
    visibility = ["//visibility:public"],
)

config_setting(
    name = "darwin",
    constraint_values = ["@platforms//os:macos"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "readme_file",
    srcs = [
        "README.md"
    ],
    visibility = ["//visibility:public"]
)
