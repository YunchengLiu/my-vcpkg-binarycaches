set(VCPKG_TARGET_ARCHITECTURE x64)

# CRT总是使用dynamic类型
set(VCPKG_CRT_LINKAGE dynamic)

# 所有依赖库使用C++20标准编译, 与主项目保持一致
# 确保boost, gtest等大型库的C++20特性能够正常使用
list(APPEND VCPKG_CMAKE_CONFIGURE_OPTIONS
    -DCMAKE_C_STANDARD=17
    -DCMAKE_C_STANDARD_REQUIRED=ON
    -DCMAKE_C_EXTENSIONS=OFF
    -DCMAKE_CXX_STANDARD=20
    -DCMAKE_CXX_STANDARD_REQUIRED=ON
    -DCMAKE_CXX_EXTENSIONS=OFF
)

# 定义需要静态链接的库列表
# VS2022的GTest适配器在gtest与gmock静态链接时能正确检测测试用例
# 启动cxx17 feature时也没问题, 这里始终静态链接来降低潜在的问题
set(STATIC_LINK_LIBRARIES
    assimp
    boost-container
    boost-date-time
    # 项目许多地方依赖于boost-graph, 由于当前boost模块混编了static—link与dynamic-link的库, 会造成BOOST_DYN_LINK宏影响部分static-link的库, graph暂时先保持动态, 后续进一步整理
    # boost-graph,
    boost-serialization
    boost-stacktrace
    fmt
    gmock
    gtest
    platform-folders
    simdutf
    spdlog
    uchardet
    xxhash

    # 传递依赖, 部分header-only的未列出
    draco # depended by assimp
    glad # depended by libigl.viewer
    glfw3 # depended by libigl.viewer
    jhasse-poly2tri # depended by assimp
    kubazip # depended by assimp
    minizip # depended by assimp
    polyclipping # depended by assimp
    pugixml # depended by assimp
    zlib # depended by assimp
    liblzma # depended by boost.iostreams
)

string(REPLACE ";" "|" STATIC_PATTERN "${STATIC_LINK_LIBRARIES}")

if(${PORT} MATCHES "^(${STATIC_PATTERN})$")
    set(VCPKG_LIBRARY_LINKAGE static)
else()
    # 未指定静态的则默认为动态链接
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

unset(STATIC_LINK_LIBRARIES)
unset(STATIC_PATTERN)
