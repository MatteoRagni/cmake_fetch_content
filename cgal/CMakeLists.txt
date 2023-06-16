# CGAL v5.5.2 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides CGAL library, but requires Eigen3 and boost libraries
#
cmake_minimum_required(VERSION 3.14)

project(cgal VERSION 5.5.2)

include(FetchContent)
FetchContent_Declare(CGAL
    URL https://github.com/CGAL/cgal/releases/download/v5.5.2/CGAL-5.5.2.tar.xz
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    DOWNLOAD_EXTRACT_TIMESTAMP ON
)
FetchContent_Populate(CGAL)   # finish fetching and unpacking before continuing

find_package(Boost REQUIRED)
# find_package(Eigen3 3.2.0 REQUIRED) # 3.2.0 is minimum version

set(CGAL_DIR "${FETCHCONTENT_BASE_DIR}/cgal-src")
find_package(CGAL REQUIRED COMPONENTS Qt5)
# Boost and its components

if(NOT Boost_FOUND)
message(STATUS "This project requires the Boost library.")
return()
endif()

include(CGAL_Eigen3_support)