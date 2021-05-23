# rules_vulkan

Bazel rules for using the [Vulkan SDK](https://vulkan.lunarg.com/sdk/home).

## Configuration

Include the following configuration in your project's `WORKSPACE` file.

```python
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "rules_vulkan",
    urls = [
        "https://github.com/jadarve/rules_vulkan/archive/refs/tags/v0.0.1.zip",
    ],
    sha256 = "25a610e1c8873b83a809a5db661648127da5a25c2202f7f845ba3c80f75b9342",
)

load("@rules_vulkan//vulkan:repositories.bzl", "vulkan_repositories")
vulkan_repositories()
```

By calling `vulkan_repositories()`, the package will look for the Vulkan SDK installed in your Operating System and create the following extra repositories:

| Repository       | Defined Targets                                                                                                                                              |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `vulkan_windows` | * `vulkan_cc_library` for compiling C/C++ targets that depend on Vulkan. <br> * `glslc` filegroup for the GLSL compiler, used internally to compile shaders. |
| `vulkan_linux`   | Nothing at the moment. The GLSL compiler is accessed directly from the system.                                                                               |

## Rules

### `glsl_header_library`

A GLSL header library defines a collection of `.glsl` files that can be included during compilation of a `glsl_shader`:

```python
load("@rules_vulkan//glsl:defs.bzl", "glsl_header_library")

glsl_header_library(
    name = "mylib_glsl_library",
    hdrs = [
        "mylib/mylib.glsl",
        "mylib/color/color.glsl",
    ],
    # path from the repository's root that will be stripped
    strip_include_prefix = "shader_lib",
    visibility = ["//visibility:public"]
)
```

### `glsl_shader`

A `glsl_shader` compiles a shader file (`.vert`, `.frag`, `.tesc`, `.tese`, `.geom`, `.comp`) to SPIR-V representation:

```python
load("@rules_vulkan//glsl:defs.bzl", "glsl_shader")


glsl_shader(
    name = "assign_shader",
    shader = "assign.comp",
    deps = [
        "//shader_lib:mylib_glsl_library"
    ],
    visibility = ["//visibility:public"]
)
```

## Examples

See the [examples](examples) folder to see how to use the rules.
