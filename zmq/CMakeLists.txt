# zmq v4.3.4 and cppzmq v4.9.0 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides libzmq and cppzmq libraries
#
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(ENABLE_DRAFTS OFF CACHE BOOL "" FORCE)
set(WITH_DOCS OFF CACHE BOOL "" FORCE)
set(WITH_PERF_TOOL OFF CACHE BOOL "" FORCE)
set(BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(CPPZMQ_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(ENABLE_CURVE OFF CACHE BOOL "" FORCE)
set(WITH_TLS OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED OFF)
set(ENABLE_CPACK OFF)

include(FetchContent)
FetchContent_Declare(
    libzmq
    # Cannot use archive version, must use 
    # URL https://github.com/zeromq/libzmq/archive/refs/tags/v4.3.4.zip
    GIT_REPOSITORY https://github.com/zeromq/libzmq
    GIT_TAG v4.3.4
    DOWNLOAD_EXTRACT_TIMESTAMP ON
    EXCLUDE_FROM_ALL)
FetchContent_Declare(
    cppzmq
    URL https://github.com/zeromq/cppzmq/archive/refs/tags/v4.9.0.zip
    DOWNLOAD_EXTRACT_TIMESTAMP ON
    EXCLUDE_FROM_ALL)

project(zmq_dependency
  VERSION 4.3.4)

FetchContent_MakeAvailable(libzmq cppzmq)
