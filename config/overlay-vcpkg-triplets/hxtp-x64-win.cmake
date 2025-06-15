set(VCPKG_TARGET_ARCHITECTURE x64)

set(VCPKG_CRT_LINKAGE dynamic)

# todo: set same compiler options with main project for all libraries
# include optimization, debug info, etc.

if(${PORT} MATCHES "gtest|gmock")
    # 当前VS2022的GTest适配器在gtest静态链接时, 能正确检测并对测试用例分类显示
    # 此处对gtest始终进行静态链接
    set(VCPKG_LIBRARY_LINKAGE static)
elseif(${PORT} MATCHES "assimp|glad|glfw3|liblzma|minizip|platform-folders|poly2tri|pugixml|zlib|xxhash|uchardet")
    set(VCPKG_LIBRARY_LINKAGE static)
elseif(${PORT} MATCHES "icu")
    # icu体积过大, 在当前项目中纯私有但仍然动态链接
    set(VCPKG_LIBRARY_LINKAGE dynamic)
else()
    # 未显式设置过的包均采用动态链接
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()
