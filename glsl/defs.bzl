"""
"""

load("@rules_vulkan//glsl:rules.bzl",
    _glsl_shader = "glsl_shader",
    _glsl_header_library = "glsl_header_library")

glsl_shader = _glsl_shader
glsl_header_library = _glsl_header_library
