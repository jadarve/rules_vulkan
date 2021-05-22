load("@rules_vulkan//glsl:repositories.bzl", "glsl_repositories")
load("@rules_vulkan//vulkan/platform:windows.bzl", "vulkan_windows")
load("@rules_vulkan//vulkan/platform:linux.bzl", "vulkan_linux")

def vulkan_repositories():
    """Loads the required repositories into the workspace
    """

    vulkan_windows(
        name = "vulkan_windows"
    )

    vulkan_linux(
        name = "vulkan_linux"
    )

    glsl_repositories()
