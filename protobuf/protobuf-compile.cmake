# Protobuf Compile
#
# Matteo Ragni, 2023
# License MIT
#
# Provides a function to compile protobuf files
#
include(CMakeParseArguments)

function(compile_protobuf_files_cpp)
  cmake_parse_arguments(COMPILE_PROTOBUF "" "MODEL" "FILES;INCLUDE_DIRECTORIES" ${ARGN})
  # Definitions
  set(PROTO_HDRS)
  set(PROTO_SRCS)
  set(PROTO_DIRS)
  set(COMPILE_PROTOBUF_HEADER_EXT ".pb.h")
  set(COMPILE_PROTOBUF_SOURCE_EXT ".pb.cc")
  # set(COMPILE_PROTOBUF_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${COMPILE_PROTOBUF_MODEL}")
  set(COMPILE_PROTOBUF_OUTPUT_DIR "${CMAKE_CURRENT_BINARY_DIR}/${COMPILE_PROTOBUF_MODEL}")

  # Get Protobuf Proto Files include directories for protoc command
  foreach(dir IN LISTS COMPILE_PROTOBUF_INCLUDE_DIRECTORIES)
    list(APPEND PROTO_DIRS "--proto_path=${dir}")
  endforeach()

  # Generate Protobuf cpp sources
  file(MAKE_DIRECTORY ${COMPILE_PROTOBUF_OUTPUT_DIR})
  foreach(PROTO_FILE IN LISTS COMPILE_PROTOBUF_FILES)
    get_filename_component(PROTO_DIR ${PROTO_FILE} DIRECTORY)
    get_filename_component(PROTO_NAME ${PROTO_FILE} NAME_WE)
    set(PROTO_HDR ${COMPILE_PROTOBUF_OUTPUT_DIR}/${PROTO_NAME}${COMPILE_PROTOBUF_HEADER_EXT})
    set(PROTO_SRC ${COMPILE_PROTOBUF_OUTPUT_DIR}/${PROTO_NAME}${COMPILE_PROTOBUF_SOURCE_EXT})
    add_custom_command(
      OUTPUT ${PROTO_SRC} ${PROTO_HDR}
      COMMAND protobuf::protoc
      ${PROTO_DIRS}
      "--cpp_out=${COMPILE_PROTOBUF_OUTPUT_DIR}"
      ${PROTO_FILE}
      DEPENDS ${COMPILE_PROTOBUF_OUTPUT_DIR} ${PROTO_FILE} protobuf::protoc
      COMMENT "Generate C++ protocol buffer for ${PROTO_FILE}"
      VERBATIM)
    list(APPEND PROTO_HDRS ${PROTO_HDR})
    list(APPEND PROTO_SRCS ${PROTO_SRC})
  endforeach()

  add_custom_target(${COMPILE_PROTOBUF_MODEL}_compile_protobuf DEPENDS ${PROTO_SRCS})

  message(STATUS "Protocol Buffer Headers for [${COMPILE_PROTOBUF_MODEL}]")
  foreach(file IN LISTS PROTO_HDRS)
    message(STATUS " -> ${file}")
  endforeach()
  message(STATUS "Protocol Buffer Sources for [${COMPILE_PROTOBUF_MODEL}]")
  foreach(file IN LISTS PROTO_SRCS)
    message(STATUS " -> ${file}")
  endforeach()

  get_target_property(protobuf_dirs protobuf::libprotobuf INTERFACE_INCLUDE_DIRECTORIES)

  add_library(${COMPILE_PROTOBUF_MODEL}_protobuf STATIC
    ${PROTO_SRCS})
  add_dependencies(${COMPILE_PROTOBUF_MODEL}_protobuf ${COMPILE_PROTOBUF_MODEL}_compile_protobuf)
  target_link_libraries(${COMPILE_PROTOBUF_MODEL}_protobuf PUBLIC 
    protobuf::libprotobuf)
  target_include_directories(${COMPILE_PROTOBUF_MODEL}_protobuf PUBLIC
    ${COMPILE_PROTOBUF_OUTPUT_DIR} ${protobuf_dirs})
  add_library(${COMPILE_PROTOBUF_MODEL}::protobuf ALIAS ${COMPILE_PROTOBUF_MODEL}_protobuf)
endfunction()