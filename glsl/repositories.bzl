

def glsl_repositories():
    """Register the available toolchains into the workspace.
    """
    
    native.register_toolchains(
        "@rules_glsl//glsl:glsl_windows_toolchain"
    )
