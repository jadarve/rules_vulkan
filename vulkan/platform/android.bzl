"""
"""

build_file_using_host_sdk = """
cc_library(
    name = "vulkan_cc_library",
    hdrs = glob([
        "host_vulkan_sdk/include/vulkan/**/*.h",
        "host_vulkan_sdk/include/vulkan/**/*.hpp",
        "host_vulkan_sdk/include/vk_video/**/*.h",
        "host_vulkan_sdk/include/vk_video/**/*.hpp",
        ]),
    includes = [
        "host_vulkan_sdk/include",
    ],
    linkstatic = False,
    visibility = ["//visibility:public"]
)

filegroup(
    name = "glslc",
    srcs = ["host_vulkan_sdk/bin/glslc"],
    visibility = ["//visibility:public"],
)
"""

build_file_using_ndk = """
cc_library(
    name = "vulkan_cc_library",
    hdrs = glob([
        "android_ndk/sources/third_party/vulkan/src/include/**/*.h",
        "android_ndk/sources/third_party/vulkan/src/include/**/*.hpp",
        "android_ndk/sources/third_party/vulkan/src/common/vulkan_wrapper.h",
        "android_ndk/sources/third_party/vulkan/src/common/android_util.h",
        ]),
    srcs = glob([
        "android_ndk/sources/third_party/vulkan/src/common/vulkan_wrapper.cpp",
        "android_ndk/sources/third_party/vulkan/src/common/android_util.cpp",
    ]),
    includes = [
        "android_ndk/sources/third_party/vulkan/src/include",
        "android_ndk/sources/third_party/vulkan/src/common",
    ],
    visibility = ["//visibility:public"]
)

filegroup(
    name = "glslc",
    srcs = ["android_ndk/shader-tools/linux-x86_64/glslc"],
    visibility = ["//visibility:public"],
)
"""

def _impl(repository_ctx):
    """
    Vulkan Android repository implementation
    """

    use_host_vulkan_sdk = repository_ctx.attr.android_use_host_vulkan_sdk

    #################################################################
    # Configure the Vulkan SDK installed in the host machine
    if use_host_vulkan_sdk:
        host_sdk_path = repository_ctx.attr.host_sdk_path
        if host_sdk_path == None:
            host_sdk_path = repository_ctx.os.environ.get("VULKAN_SDK", None)

        if host_sdk_path == "" or host_sdk_path == None:
            host_sdk_path = "/usr"

        repository_ctx.symlink(host_sdk_path, "host_vulkan_sdk")

    glslc_path = repository_ctx.which("glslc")
    if glslc_path == None:
        fail("Unable to find glslc binary in the system")

    #################################################################
    # Android NDK
    ndk_home = repository_ctx.os.environ.get("ANDROID_NDK_HOME", None)
    if ndk_home == None:
        fail("ANDROID_NDK_HOME environment variable not found")

    repository_ctx.symlink(ndk_home, "android_ndk")

    file_content = ""
    if use_host_vulkan_sdk:
        file_content = build_file_using_host_sdk

        # otherwise, use the Android NDK sources
    else:
        file_content = build_file_using_ndk

    repository_ctx.file("BUILD.bazel", file_content)

vulkan_android = repository_rule(
    implementation = _impl,
    local = True,
    environ = ["ANDROID_NDK_HOME", "VULKAN_SDK"],
    attrs = {
        "host_sdk_path": attr.string(
            default = "",
            mandatory = False,
            doc = "Path to the host Vulkan SDK",
        ),
        "android_use_host_vulkan_sdk": attr.bool(
            default = False,
            mandatory = False,
            doc = "If True, use the host Vulkan SDK headers, otherwise use those provided by the NDK.",
        ),
    },
)
