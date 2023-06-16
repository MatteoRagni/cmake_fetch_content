# gRPC v1.43.0 Fetch Content
#
# Matteo Ragni, 2023
# License MIT
#
# Provides gRPC libraries, the gRPC compiler and functions
# to compile .proto files
#
cmake_minimum_required(VERSION 3.14)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(BUILD_TESTING OFF CACHE BOOL "" FORCE)
set(BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set(gRPC_BUILD_CSHARP_EXT OFF CACHE BOOL "" FORCE)
set(gRPC_INSTALL OFF CACHE BOOL "" FORCE)
set(ABSL_PROPAGATE_CXX_STD ON CACHE BOOL "" FORCE)
set(ABSL_ENABLE_INSTALL OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_INSTALL OFF CACHE BOOL "" FORCE)
set(BENCHMARK_INSTALL_DOCS OFF CACHE BOOL "" FORCE)
set(BENCHMARK_ENABLE_GTEST_TESTS OFF CACHE BOOL "" FORCE)
set(protobuf_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(RE2_BUILD_TESTING OFF CACHE BOOL "" FORCE)

include(FetchContent)
FetchContent_Declare(
    grpc
    GIT_REPOSITORY https://github.com/grpc/grpc.git
    GIT_TAG v1.43.0
    EXCLUDE_FROM_ALL)
set(FETCHCONTENT_QUIET OFF)

project(grpc_dependency
  VERSION 1.43.0)

FetchContent_MakeAvailable(grpc)

set(grpc_protoc $<TARGET_FILE:protoc>)
set(grpc_protoc_plugin $<TARGET_FILE:grpc_cpp_plugin>)

function(grpc_compile_interface INTERFACE_NAME INTERFACE_FILE OUTPUT_DIR)
  get_filename_component(proto_fullfile ${INTERFACE_FILE} ABSOLUTE)
  get_filename_component(proto_basepath ${proto_fullfile} PATH)
  get_filename_component(proto_basename ${INTERFACE_FILE} NAME_WE)
  set("${INTERFACE_NAME}_proto_hdrs" "${OUTPUT_DIR}/${proto_basename}.pb.h" PARENT_SCOPE)
  set("${INTERFACE_NAME}_proto_srcs" "${OUTPUT_DIR}/${proto_basename}.pb.cc" PARENT_SCOPE)
  set("${INTERFACE_NAME}_grpc_hdrs" "${OUTPUT_DIR}/${proto_basename}.grpc.pb.h" PARENT_SCOPE)
  set("${INTERFACE_NAME}_grpc_srcs" "${OUTPUT_DIR}/${proto_basename}.grpc.pb.cc" PARENT_SCOPE)
  set("${INTERFACE_NAME}_hdrs" "${${INTERFACE_NAME}_proto_hdrs} ${${INTERFACE_NAME}_grpc_hdrs}" PARENT_SCOPE)
  set("${INTERFACE_NAME}_srcs" "${${INTERFACE_NAME}_proto_srcs} ${${INTERFACE_NAME}_grpc_srcs}" PARENT_SCOPE)
  set(output_files "${${INTERFACE_NAME}_srcs} ${${INTERFACE_NAME}_hdrs}")

  add_custom_command(
    OUTPUT ${output_files}
    COMMAND "${grpc_protoc}"
    ARGS --grpc_out "${OUTPUT_DIR}" --cpp_out "${OUTPUT_DIR}"
         -I "${proto_basepath}" --plugin=protoc-gen-grpc="${grpc_protoc_plugin}"
         "${proto_fullfile}"
    DEPENDS "${proto_fullfile}")
endfunction()

function(grpc_interface_target INTERFACE_NAME INTERFACE_FILE)
  # FIXME: This will not consider redistributable code!
  grpc_compile_interface(${INTERFACE_NAME} ${INTERFACE_FILE} ${CMAKE_CURRENT_BINARY_DIR})
  add_library(${INTERFACE_NAME}_grpc_library STATIC)
  target_sources(${INTERFACE_NAME}_grpc_library
    PRIVATE "${${INTERFACE_NAME}_proto_srcs}" "${${INTERFACE_NAME}_grpc_srcs}"
    PUBLIC "${${INTERFACE_NAME}_proto_hdrs}" "${${INTERFACE_NAME}_grpc_hdrs}")
  target_include_directories(${INTERFACE_NAME}_grpc_library PUBLIC ${CMAKE_CURRENT_BINARY_DIR})
  set_target_properties(${INTERFACE_NAME}_grpc_library PROPERTIES
    POSITION_INDIPENDENT_CODE ON)
  target_link_libraries(${INTERFACE_NAME}_grpc_library PUBLIC
    grpc++ grpc++_reflection libprotobuf)
  add_library(${INTERFACE_NAME}::grpc ALIAS ${INTERFACE_NAME}_grpc_library)
endfunction()