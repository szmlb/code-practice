cmake_minimum_required(VERSION 3.0.0)
project(main VERSION 0.1.0)

FIND_PACKAGE (Eigen3 REQUIRED)
FIND_PACKAGE (Threads REQUIRED)
set(CMAKE_CXX_FLAGS "-g -Wall -O3 -std=c++17")

set( SOURCES
  main.cpp
  )

set( HEADERS
  include/tabulate/tabulate.hpp
  )

add_executable(main ${SOURCES} ${HEADERS})
target_link_libraries (main Eigen3::Eigen)
target_link_libraries (main pthread)
target_include_directories(main PUBLIC include)
