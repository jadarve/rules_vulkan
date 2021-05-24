
#include <cstdlib>
#include <iostream>

#include <vulkan/vulkan.hpp>

int main() {

    const vk::ApplicationInfo appInfo = vk::ApplicationInfo()
            .setPApplicationName("list_extensions")
            .setApplicationVersion(0)
            .setEngineVersion(0)
            .setPEngineName("rules_vulkan");

    const vk::InstanceCreateInfo instanceInfo = vk::InstanceCreateInfo()
            .setPApplicationInfo(&appInfo);

    vk::Instance instance;
    vk::Result result = vk::createInstance(&instanceInfo, nullptr, &instance);
    if (result != vk::Result::eSuccess) {
        std::cerr << "error creating vulkan instance" << std::endl;
        exit(-1);
    }

    auto extensions = vk::enumerateInstanceExtensionProperties();
    for (const auto& ext: extensions) {
        std::cout << ext.extensionName << std::endl; 
    }

    return EXIT_SUCCESS;
}
