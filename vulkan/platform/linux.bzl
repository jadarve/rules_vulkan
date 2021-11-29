"""
"""

def _impl(repository_ctx):

    sdk_path = repository_ctx.attr.path

    if sdk_path == '':
        sdk_path = repository_ctx.os.environ.get("VULKAN_SDK", None)

    if sdk_path == '' or sdk_path == None:
        print("VULKAN_SDK environment variable not found, using /usr")
        sdk_path = "/usr"

    repository_ctx.symlink(sdk_path, "vulkan_sdk_linux")

    glslc_path = repository_ctx.which("glslc")
    if glslc_path == None:
        fail("Unable to find glslc binary in the system")

    file_content = """

cc_library(
    name = "vulkan_cc_library",
    srcs = ["vulkan_sdk_linux/lib/x86_64-linux-gnu/libvulkan.so"],
    hdrs = glob([
        "vulkan_sdk_linux/include/vulkan/**/*.h",
        "vulkan_sdk_linux/include/vulkan/**/*.hpp",
        ]),
    includes = ["vulkan"],
    visibility = ["//visibility:public"]
)

# FIXME: I cannot actually run this one in _glsl_shader. There is an error
# when running _glsl_shader rule
filegroup(
    name = "glslc",
    srcs = ["vulkan_sdk_linux/bin/glslc"],
    visibility = ["//visibility:public"],
)
""".format(str(glslc_path)[1:])

    repository_ctx.file("BUILD.bazel", file_content)

vulkan_linux = repository_rule(
    implementation = _impl,
    local = True,
    environ = ["VULKAN_SDK"],
    attrs = {
        "path": attr.string(mandatory = False),
    },
)
