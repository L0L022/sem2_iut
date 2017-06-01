cmake_minimum_required(VERSION 3.1)

project(EntityX)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules")

find_package(SFML 2 COMPONENTS system window graphics REQUIRED)
include_directories(${SFML_INCLUDE_DIR})

find_package(EntityX REQUIRED)
include_directories(${ENTITYX_INCLUDE_DIRS})

set(EXAMPLE_SRC ${CMAKE_BINARY_DIR}/src/example.cc)

set(RESOURCES ${CMAKE_SOURCE_DIR}/resources)
configure_file(src/example.cc src/example.cc)

add_executable(example ${EXAMPLE_SRC})
target_link_libraries(example ${SFML_LIBRARIES} ${ENTITYX_LIBRARIES})
