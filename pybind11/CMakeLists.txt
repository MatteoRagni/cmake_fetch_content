# pybind11 v2.8.1 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides pybind11 library
#
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(FetchContent)

project(pybind11)

# Dependency Options
set(PYBIND11_TEST OFF)
set(PYBIND11_INSTALL OFF)

FetchContent_Declare(
  pybind11
  GIT_REPOSITORY "https://github.com/pybind/pybind11.git"
  GIT_TAG "v2.8.1")
FetchContent_MakeAvailable(pybind11)
