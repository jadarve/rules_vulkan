"""
"""

def _impl(repository_ctx):

    ndk_home = repository_ctx.os.environ.get('ANDROID_NDK_HOME', None)
    if ndk_home == None:
        fail('ANDROID_NDK_HOME environment variable not found')

    repository_ctx.symlink(ndk_home, "vulkan_sdk_android")    

    glslc_path = repository_ctx.which("glslc")
    if glslc_path == None:
        fail("Unable to find glslc binary in the system")

    file_content = """

cc_library(
    name = "vulkan_cc_library",
    hdrs = glob([
        "vulkan_sdk_android/sources/third_party/vulkan/src/include/**/*.h",
        "vulkan_sdk_android/sources/third_party/vulkan/src/include/**/*.hpp",
        "vulkan_sdk_android/sources/third_party/vulkan/src/common/vulkan_wrapper.h",
        # TODO: common/android_util.h
        ]),
    srcs = glob([
        "vulkan_sdk_android/sources/third_party/vulkan/src/common/vulkan_wrapper.cpp",
    ]),
    includes = [
        "vulkan_sdk_android/sources/third_party/vulkan/src/include",
        "vulkan_sdk_android/sources/third_party/vulkan/src/common",
    ],
    visibility = ["//visibility:public"]
)
""".format(str(glslc_path)[1:])

    repository_ctx.file("BUILD.bazel", file_content)

vulkan_android = repository_rule(
    implementation = _impl,
    local = True,
    environ = ["ANDROID_NDK_HOME"],
    # attrs = {
    #     "ndk_path": attr.string(mandatory = False),
    # },
)
