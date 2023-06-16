# Boost v1.79.0 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides Boost Libraries. It is currently designed to provide the following 
# dependencies: array, bind, smart_ptr, asio, thread
# It downloads all the dependencies for those libraries, so that they
# becames available.
#
cmake_minimum_required(VERSION 3.24)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(FETCHCONTENT_UPDATES_DISCONNECTED ON)

set(BOOST_ENABLE_CMAKE ON)
set(BOOST_VERSION 1.79.0)

set(boost_git_tag "boost-${BOOST_VERSION}")
set(boost_library_repository_base "https://github.com/boostorg/{{library_name}}.git")
set(boost_libraries_name
    # Dependencies
    algorithm
    align
    assert
    atomic
    chrono
    concept_check
    config
    container
    container_hash
    context
    conversion
    core
    coroutine
    date_time
    detail
    exception
    function
    function_types
    fusion
    integer
    intrusive
    io
    iterator
    lexical_cast
    move
    mp11
    mpl
    numeric_conversion
    optional
    pool
    predef
    preprocessor
    range
    ratio
    rational
    regex
    static_assert
    system
    throw_exception    
    tokenizer
    tuple
    type_index
    type_traits
    typeof
    unordered
    utility
    variant
    variant2
    winapi
    # Actually used
    array
    bind
    smart_ptr
    asio
    thread)

include(FetchContent)

set(boost_fetch_content_names "")
foreach(boost_library ${boost_libraries_name})
  string(REPLACE "{{library_name}}" ${boost_library} boost_library_repository ${boost_library_repository_base})
  set(boost_fetch_content_name "boost_${boost_library}")
  list(APPEND boost_fetch_content_names ${boost_fetch_content_name})
  message(STATUS "${boost_library} from ${boost_library_repository} as ${boost_fetch_content_name}")
  FetchContent_Declare(${boost_fetch_content_name}
    GIT_REPOSITORY ${boost_library_repository}
    GIT_TAG ${boost_git_tag}
    GIT_SHALLOW 1
    GIT_SUBMODULES_RECURSE OFF)
endforeach()

# Compile options for boost
set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)

project(boost VERSION ${BOOST_VERSION})

FetchContent_MakeAvailable(${boost_fetch_content_names})
