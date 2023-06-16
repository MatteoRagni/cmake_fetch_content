# capnproto v0.8.0 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides capnproto library
#
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(FetchContent)
FetchContent_Declare(
  CapNProto
  GIT_REPOSITORY https://github.com/capnproto/capnproto.git
  GIT_TAG        57a4ca5af5a7f55b768a9d9d6655250bffb1257f)

project(capnproto_dependency
  VERSION 0.8.0)
  set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
  FetchContent_MakeAvailable(CapNProto)