cmake_minimum_required(VERSION 3.0.0)
project(pointer_sample VERSION 0.1.0)

include_directories("include")
add_executable(pointer_sample main.cpp ./src/pointer_sample.cpp)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
