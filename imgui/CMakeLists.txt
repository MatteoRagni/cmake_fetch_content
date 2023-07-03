# Dear ImGUI v1.89.6. Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides imgui, but requires installed versions for Vulkan and glfw3
# as renderer on linux. On Windows it requires DirectX11.
#
# In order to use it on Linux Ubuntu 22.04:
#  - install the package libglfw3-dev
#  - install the vulkan-sdk package after including the sources as 
#    described in this page: https://vulkan.lunarg.com/doc/view/latest/linux/getting_started_ubuntu.html
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)


set(IMGUI_SOURCES_DIR ${CMAKE_CURRENT_BINARY_DIR}/extract-deps/imgui)
include(FetchContent)

FetchContent_Populate(imgui
  URL https://github.com/ocornut/imgui/archive/refs/tags/v1.89.6.zip
  SOURCE_DIR ${IMGUI_SOURCES_DIR}
  DOWNLOAD_EXTRACT_TIMESTAMP ON
)

if (WIN32)
  set(IMGUI_BACKEND_SOURCES
    ${IMGUI_SOURCES_DIR}/backends/imgui_impl_dx11.cpp
    ${IMGUI_SOURCES_DIR}/backends/imgui_impl_win32.cpp)
  set(IMGUI_LINK_LIBRARIES d3d11)
else()
  set(IMGUI_BACKEND_SOURCES 
    ${IMGUI_SOURCES_DIR}/backends/imgui_impl_glfw.cpp
    ${IMGUI_SOURCES_DIR}/backends/imgui_impl_vulkan.cpp)
  set(IMGUI_LINK_LIBRARIES glfw vulkan)
endif()


add_library(imgui_library_static STATIC
  ${IMGUI_SOURCES_DIR}/imgui.cpp
  ${IMGUI_SOURCES_DIR}/imgui_draw.cpp
  ${IMGUI_SOURCES_DIR}/imgui_demo.cpp
  ${IMGUI_SOURCES_DIR}/imgui_tables.cpp
  ${IMGUI_SOURCES_DIR}/imgui_widgets.cpp

  ${IMGUI_BACKEND_SOURCES}
)

target_link_libraries(imgui_library_static PUBLIC ${IMGUI_LINK_LIBRARIES})

target_include_directories(imgui_library_static
PUBLIC
  ${IMGUI_SOURCES_DIR}
  ${IMGUI_SOURCES_DIR}/backends
)

add_library(ImGUI::Static ALIAS imgui_library_static)