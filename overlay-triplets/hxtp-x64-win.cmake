set(VCPKG_TARGET_ARCHITECTURE x64)

set(VCPKG_CRT_LINKAGE dynamic)

# todo: set same compiler options with main project for all libraries
# include optimization, debug info, etc.

if(${PORT} MATCHES "gtest|gmock")
    # 当前VS2022的GTest适配器在gtest静态链接时, 能正确检测并对测试用例分类显示
    # 此处对gtest始终进行静态链接
    # 此外, gtest静态链接也有助于解决testing::Matcher<std::string_view>的链接问题
    # 不过在更新vcpkg后也设置了gtest的cxx17 feature, 动态链接也可解决
    set(VCPKG_LIBRARY_LINKAGE static)
else()
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()
