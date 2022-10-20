
# See https://github.com/bazelbuild/bazel/blob/master/src/conditions/BUILD for standard conditions.
# Unfortunately, there is no one for android at the moment.

config_setting (
    name = "linux",
    constraint_values = [
        "@platforms//os:linux"
    ],
    visibility = ["//visibility:public"]
)

config_setting (
    name = "android",
    values = {
        # at least this works for building mediapipe AAR
        "host_crosstool_top": "@bazel_tools//tools/cpp:toolchain",
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
