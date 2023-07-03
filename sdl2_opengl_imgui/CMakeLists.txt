# Dear ImGUI v1.89.6. with SDL2 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides imgui, with SDL2 support. This allow to implement with a cross platform
# renderer based on SDL2/OpenGL2 (a little old but, but nevertheless it is ok most of
# the time)
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

project(ImGUI VERSION 1.89.6)

set(SDL_SHARED OFF CACHE BOOL "" FORCE)
set(SDL_STATIC ON CACHE BOOL "" FORCE)
set(SDL_TEST OFF CACHE BOOL "" FORCE)
set(SDL_TESTS OFF CACHE BOOL "" FORCE)
set(SDL_INSTALL_TESTS OFF CACHE BOOL "" FORCE)

set(SDL_DISKAUDIO OFF CACHE BOOL "" FORCE)
set(SDL_DUMMYAUDIO OFF CACHE BOOL "" FORCE)
set(SDL_ALSA OFF CACHE BOOL "" FORCE)
set(SDL_PULSEAUDIO OFF CACHE BOOL "" FORCE)
set(SDL_PIPEWIRE OFF CACHE BOOL "" FORCE)
set(SDL_NAS OFF CACHE BOOL "" FORCE)
set(SDL_SNDIO OFF CACHE BOOL "" FORCE)
set(SDL_ARTS OFF CACHE BOOL "" FORCE)

set(IMGUI_SOURCES_DIR ${CMAKE_CURRENT_BINARY_DIR}/extract-deps/imgui)
include(FetchContent)

FetchContent_Declare(SDL2
    URL https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.28.1.zip
    DOWNLOAD_EXTRACT_TIMESTAMP ON)

FetchContent_Populate(imgui
  URL https://github.com/ocornut/imgui/archive/refs/tags/v1.89.6.zip
  SOURCE_DIR ${IMGUI_SOURCES_DIR}
  DOWNLOAD_EXTRACT_TIMESTAMP ON)

FetchContent_MakeAvailable(SDL2)
add_library(SDL2::Static ALIAS SDL2-static)
add_library(SDL2::Main ALIAS SDL2main)

find_package(OpenGL REQUIRED)

add_library(imgui_library_static STATIC
  ${IMGUI_SOURCES_DIR}/imgui.cpp
  ${IMGUI_SOURCES_DIR}/imgui_draw.cpp
  ${IMGUI_SOURCES_DIR}/imgui_demo.cpp
  ${IMGUI_SOURCES_DIR}/imgui_tables.cpp
  ${IMGUI_SOURCES_DIR}/imgui_widgets.cpp
  # Backend
  ${IMGUI_SOURCES_DIR}/backends/imgui_impl_sdl2.cpp
  ${IMGUI_SOURCES_DIR}/backends/imgui_impl_opengl2.cpp
)

target_link_libraries(imgui_library_static PUBLIC SDL2::Main SDL2::Static ${OPENGL_LIBRARIES})

target_include_directories(imgui_library_static
  PUBLIC
    ${IMGUI_SOURCES_DIR}
    ${IMGUI_SOURCES_DIR}/backends)

add_library(ImGUI::Static ALIAS imgui_library_static)