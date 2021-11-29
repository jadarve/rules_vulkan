

def glsl_repositories():
    """Register the available toolchains into the workspace.
    """
    
    native.register_toolchains(
        "@rules_vulkan//glsl:glsl_windows_toolchain",
        "@rules_vulkan//glsl:glsl_linux_toolchain",
        "@rules_vulkan//glsl:glsl_macos_toolchain",
    )
