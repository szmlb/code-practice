# Eliminate overlapped convex hulls

This is a project to load convex hulls in a two-dimensional space from a json file, eliminating overlapped convex hulls, and then saving the resulting convex hulls to another json file.

## Project structure
The directory structure of this project is as below.
The project adopted CMake as a software compilation tool for C++ project and ```CMakeLists.txt``` defines the project configuration.
```data``` includes input and output data, ```external``` includes third-party json library, and ```src``` includes source files.
```
convexhull_overlap_detection
├── CMakeLists.txt
├── README.md
├── data
│   ├── convex_hulls.json
│   └── result_convex_hulls.json
├── external
│   └── nlohmann_json
└── src
    ├── convexHull.cc
    ├── convexHull.h
    ├── convexHullOverlapDetector.cc
    ├── convexHullOverlapDetector.h
    ├── convexHullParser.cc
    ├── convexHullParser.h
    └── main.cc
```

## How to build and run the project

### Requirements
- CMake version >= 3.24.2
- GCC version >= 7.5.0 or Clang version >= 6.0.0

Note that this project has been tested only on ubuntu 20.04.

### Build
Open your terminal and navigate to the root directory (```woven-tech-challenge```).

Then, type the followings:
```
mkdir build
cd ./build
cmake -DCMAKE_BUILD_TYPE=Release ..
make
```

### Run
After the build is done successfully without any errors, type the following command inside the ```build``` directory:
```
./removeConvexHullOverlap
```
The terminal should indicate the message as below.
```
Overlapped pairs detected:
(1 2) (4 3) (5 6) (9 10) (9 11) (10 11)

Checking the overlap area ratio...

Pair (1 2): overlap area is 27.7183
Area of convex hull ID 1: 50.3126 (55.0921% occupied)
Area of convex hull ID 2: 122.304 (22.6635% occupied)
Pair (4 3): overlap area is 11.6061
Area of convex hull ID 4: 11.6061 (100% occupied)
Area of convex hull ID 3: 118.131 (9.82481% occupied)
Pair (5 6): overlap area is 8.17953
Area of convex hull ID 5: 64.0376 (12.773% occupied)
Area of convex hull ID 6: 65.6599 (12.4574% occupied)
Pair (9 10): overlap area is 15.8528
Area of convex hull ID 9: 33.575 (47.2161% occupied)
Area of convex hull ID 10: 33.772 (46.9406% occupied)
Pair (9 11): overlap area is 30.3466
Area of convex hull ID 9: 33.575 (90.3847% occupied)
Area of convex hull ID 11: 130.379 (23.2757% occupied)
Pair (10 11): overlap area is 20.4542
Area of convex hull ID 10: 33.772 (60.5656% occupied)
Area of convex hull ID 11: 130.379 (15.6883% occupied)

To be removed:
Convex hull ID: 1 4 9 10
```
### Check the result
Navigate to the ```data``` directory, then you should find ```result_convex_hulls.json``` file.

## References
- C. Ericson, "Real-time collision detection," Crc Press, 2004
