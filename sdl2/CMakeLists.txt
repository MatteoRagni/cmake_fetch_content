# SDL2  Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides SDL2 support (no audio)
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

project(SDL2 VERSION 2.28.1)

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

include(FetchContent)

FetchContent_Declare(SDL2
    URL https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.28.1.zip
    DOWNLOAD_EXTRACT_TIMESTAMP ON)

FetchContent_MakeAvailable(SDL2)

add_library(SDL2::Static ALIAS SDL2-static)
add_library(SDL2::Main ALIAS SDL2main)
