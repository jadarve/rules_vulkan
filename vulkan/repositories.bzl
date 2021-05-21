load("@rules_vulkan//glsl:repositories.bzl", "glsl_repositories")
load("@rules_vulkan//vulkan/platform:windows.bzl", "vulkan_windows")

def vulkan_repositories():
    """Loads the required repositories into the workspace
    """

    vulkan_windows(
        name = "vulkan_windows"
    )

    glsl_repositories()
