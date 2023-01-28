cmake_minimum_required(VERSION 3.0.0)
project(main VERSION 0.1.0)

FIND_PACKAGE (Eigen3 3.0.0)
set(CMAKE_CXX_FLAGS "-g -Wall -O3 -std=c++17")

add_executable(main main.cpp src/CallerClass.hpp src/CalleeClass.hpp)
