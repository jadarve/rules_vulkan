"""
"""

def _impl(repository_ctx):

    sdk_path = repository_ctx.attr.path

    if sdk_path == '':
        sdk_path = repository_ctx.os.environ.get("VULKAN_SDK", None)

    if sdk_path == '' or sdk_path == None:
        fail("Unable to find Vulkan SDK")

    repository_ctx.symlink(sdk_path, "vulkan_sdk_macos")

    glslc_path = repository_ctx.which("glslc")
    if glslc_path == None:
        fail("Unable to find glslc binary in the system")

    file_content = """

cc_library(
    name = "vulkan_cc_library",
    # using libvulkan.1.dylib and libvulkan.1.x.xxx.dylib from sdk
    srcs = glob(["vulkan_sdk_macos/lib/libvulkan.1*.dylib"]),
    hdrs = glob([
        "vulkan_sdk_macos/include/vulkan/**/*.h",
        "vulkan_sdk_macos/include/vulkan/**/*.hpp",
    ]),
    includes = ["vulkan_sdk_macos/include"],
    visibility = ["//visibility:public"]
)

filegroup(
    name = "glslc",
    srcs = ["vulkan_sdk_macos/bin/glslc"],
    visibility = ["//visibility:public"],
)
""".format(str(glslc_path)[1:])

    repository_ctx.file("BUILD.bazel", file_content)

vulkan_macos = repository_rule(
    implementation = _impl,
    local = True,
    environ = ["VULKAN_SDK"],
    attrs = {
        "path": attr.string(mandatory = False),
    },
)
