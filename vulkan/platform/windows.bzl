"""
"""

def _impl(repository_ctx):

    sdk_path = repository_ctx.attr.path

    if sdk_path == '':
        sdk_path = repository_ctx.os.environ["VULKAN_SDK"]

    if sdk_path == '' or sdk_path == None:
        fail("Unable to find Vulkan SDK")

    repository_ctx.symlink(sdk_path, "vulkan_sdk_windows")

    file_content = """
cc_library(
    name = "vulkan_cc_library",
    srcs = ["vulkan_sdk_windows/Lib/vulkan-1.lib"],
    hdrs = glob([
        "vulkan_sdk_windows/Include/**/*.h",
        "vulkan_sdk_windows/Include/**/*.hpp",
        ]),
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
    implementation = _impl,
    local = True,
    environ = ["VULKAN_SDK"],
    attrs = {
        "path": attr.string(mandatory = False),
    },
)
