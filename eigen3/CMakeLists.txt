# Eigen3 v3.3.9 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides Eigen3 library
#
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(FetchContent)

project(Eigen)

option(TIRE_GROUND_FORCE_EIGEN_DOWNLOAD 
  "Force download of Eigen instead of using system version" ON)

if(NOT TIRE_GROUND_FORCE_EIGEN_DOWNLOAD)
find_package(Eigen3 3.3 NO_MODULE)
endif()
if (Eigen3_FOUND)
  add_library(local_eigen INTERFACE IMPORTED GLOBAL)
  target_link_libraries(local_eigen INTERFACE Eigen3::Eigen)
  add_library(Eigen::Eigen ALIAS local_eigen)
else()
  message(STATUS "Eigen3 not found, downloading from repository")
  FetchContent_Declare(Eigen3
    URL https://gitlab.com/libeigen/eigen/-/archive/3.3.9/eigen-3.3.9.zip
    DOWNLOAD_EXTRACT_TIMESTAMP ON)
  FetchContent_MakeAvailable(Eigen3)
  
  set(EIGEN_BUILD_PKGCONFIG OFF CACHE BOOL "" FORCE)
  set(BUILD_TESTING OFF CACHE BOOL "" FORCE)

  add_library(Eigen::Eigen ALIAS eigen)
endif()