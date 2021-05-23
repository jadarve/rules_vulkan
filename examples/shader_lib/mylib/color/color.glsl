#ifndef MYLIB_COLOR_GLSL_
#define MYLIB_COLOR_GLSL_

uint color_rgba2gray(const uvec4 RGBA) {

    return uint(dot(RGBA, vec4(0.29899999, 0.58700001, 0.114, 0.0)));
}

#endif // MYLIB_COLOR_GLSL_