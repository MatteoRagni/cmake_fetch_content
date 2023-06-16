# gFlags v2.2.2. Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides gFlags library
#
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(FetchContent)
FetchContent_Declare(gflags
    GIT_REPOSITORY https://github.com/gflags/gflags
    GIT_TAG v2.2.2)

set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(INSTALL_HEADERS OFF CACHE BOOL "" FORCE)
set(INSTALL_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(INSTALL_STATIC_LIBS OFF CACHE BOOL "" FORCE)
set(REGISTER_INSTALL_PREFIX OFF CACHE BOOL "" FORCE)

project(gflags_dependency
  VERSION 2.2.2)
FetchContent_MakeAvailable(gflags)
