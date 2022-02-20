# rules_vulkan

Bazel rules for using the [Vulkan SDK](https://vulkan.lunarg.com/sdk/home).

## Configuration

Include the following configuration in your project's `WORKSPACE` file.

```python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "rules_vulkan",
    remote = "https://github.com/jadarve/rules_vulkan.git",
    tag = "v0.0.6"
)

load("@rules_vulkan//vulkan:repositories.bzl", "vulkan_repositories")
vulkan_repositories()
```

By calling `vulkan_repositories()`, the package will look for the Vulkan SDK installed in your Operating System and create the following extra repositories:

| Repository       | Defined Targets                                                                                                                                              |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `vulkan_windows` | * `vulkan_cc_library` for compiling C/C++ targets that depend on Vulkan. <br> * `glslc` filegroup for the GLSL compiler, used internally to compile shaders. |
| `vulkan_linux`   | Nothing at the moment. The GLSL compiler is accessed directly from the system.
| `vulkan_macos`   | * `vulkan_cc_library` for compiling C/C++ targets that depend on Vulkan. <br> * `glslc` filegroup for the GLSL compiler, used internally to compile shaders. |

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
