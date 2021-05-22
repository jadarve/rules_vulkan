"""
"""

def _impl(repository_ctx):

    vulkan_sdk = repository_ctx.os.environ["VULKAN_SDK"]
    if len(vulkan_sdk) == 0:
        print("VULKAN_SDK environment variable not found")

    file_content = """

# BIG TODO!
cc_library(
    name = "vulkan_cc_library",
    srcs = ["vulkan_sdk_windows/Lib/vulkan-1.lib"],
    hdrs = glob([
        "usr/include/vulkan/**/*.h",
        "usr/include/vulkan/**/*.hpp",
        ]),
    includes = ["vulkan"],
    visibility = ["//visibility:public"]
)
"""
    
    repository_ctx.file("BUILD.bazel", file_content)


vulkan_linux = repository_rule(
    implementation = _impl,
    local = True,
)
