cmake_minimum_required(VERSION 3.16.3)
project(removeConvexHullOverlap VERSION 0.0.1)

set(SOURCES
    src/main.cc
    src/convexHull.cc
    src/convexHullParser.cc
    src/convexHullOverlapDetector.cc
)

set(HEADERS
    src/convexHull.h
    src/convexHullParser.h
    src/convexHullOverlapDetector.h
)

add_executable(removeConvexHullOverlap ${SOURCES} ${HEADERS})
target_include_directories(removeConvexHullOverlap PUBLIC external/nlohmann_json/include)

target_compile_options(removeConvexHullOverlap PUBLIC -O3 -Wall)
target_compile_features(removeConvexHullOverlap PUBLIC cxx_std_17)

# Disble this if no output messages required
target_compile_definitions(removeConvexHullOverlap PRIVATE OVERLAP_DETECTOR_VERBOSE)
