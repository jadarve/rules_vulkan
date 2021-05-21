"""
"""

def _impl(repository_ctx):

    sdk_path = repository_ctx.os.environ["VULKAN_SDK"]

    repository_ctx.symlink(sdk_path, "vulkan_sdk_windows")

    file_content = """
cc_library(
    name = "vulkan_cc_library",
    srcs = ["vulkan_sdk_windows/Lib/vulkan-1.lib"],
    hdrs = glob(["vulkan_sdk_windows/Include/**/*.h"]),
    includes = ["vulkan_sdk_windows/Include"],
    visibility = ["//visibility:public"]
)

filegroup(
    name = "glslc",
    srcs = ["vulkan_sdk_windows/Bin/glslc.exe"],
    visibility = ["//visibility:public"],
)
"""

    repository_ctx.file("BUILD.bazel", file_content)

vulkan_windows = repository_rule(
    implementation=_impl,
    local = True,
    environ = ["VULKAN_SDK"]
)
