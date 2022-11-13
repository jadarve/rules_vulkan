"""
"""

def _impl(repository_ctx):
    """
    Vulkan linux repository implementation
    """

    sdk_path = repository_ctx.attr.path
    lib_path = "lib"

    if sdk_path == "":
        sdk_path = repository_ctx.os.environ.get("VULKAN_SDK", None)

    if sdk_path == "" or sdk_path == None:
        sdk_path = "/usr"
        lib_path = "lib/x86_64-linux-gnu"

    repository_ctx.symlink(sdk_path, "vulkan_sdk_linux")

    glslc_path = repository_ctx.which("glslc")
    if glslc_path == None:
        fail("Unable to find glslc binary in the system")

    file_content = """

cc_library(
    name = "vulkan_cc_library",
    srcs = ["vulkan_sdk_linux/{0}/libvulkan.so"],  # replace lib_path
    hdrs = glob([
        "vulkan_sdk_linux/include/vulkan/**/*.h",
        "vulkan_sdk_linux/include/vulkan/**/*.hpp",
        ]),
    visibility = ["//visibility:public"]
)

filegroup(
    name = "glslc",
    srcs = ["vulkan_sdk_linux/bin/glslc"],
    visibility = ["//visibility:public"],
)
""".format(lib_path)

    repository_ctx.file("BUILD.bazel", file_content)

vulkan_linux = repository_rule(
    implementation = _impl,
    local = True,
    environ = ["VULKAN_SDK"],
    attrs = {
        "path": attr.string(mandatory = False),
    },
)
