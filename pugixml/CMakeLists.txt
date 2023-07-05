# pugixml v1.13 via FetchContent
#
# Matteo Ragni, 2023
# License MIT
#
# Provides pugixml library
#
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

include(FetchContent)
FetchContent_Declare(
    pugixml
    URL https://github.com/zeux/pugixml/archive/refs/tags/v1.13.zip
    DOWNLOAD_EXTRACT_TIMESTAMP ON
    EXCLUDE_FROM_ALL)

project(pugixml
  VERSION 1.13.0)

FetchContent_MakeAvailable(pugixml)