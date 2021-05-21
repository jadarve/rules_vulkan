load("@rules_vulkan//glsl:repositories.bzl", "glsl_repositories")

def vulkan_repositories():
    """Loads the required repositories into the workspace
    """

    glsl_repositories()
