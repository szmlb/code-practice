# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build

# Include any dependencies generated for this target.
include CMakeFiles/removeConvexHullOverlap.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/removeConvexHullOverlap.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/removeConvexHullOverlap.dir/flags.make

CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.o: CMakeFiles/removeConvexHullOverlap.dir/flags.make
CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.o: ../src/main.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.o -c /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/main.cc

CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/main.cc > CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.i

CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/main.cc -o CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.s

CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.o: CMakeFiles/removeConvexHullOverlap.dir/flags.make
CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.o: ../src/convexHull.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.o -c /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHull.cc

CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHull.cc > CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.i

CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHull.cc -o CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.s

CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.o: CMakeFiles/removeConvexHullOverlap.dir/flags.make
CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.o: ../src/convexHullParser.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.o -c /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHullParser.cc

CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHullParser.cc > CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.i

CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHullParser.cc -o CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.s

CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.o: CMakeFiles/removeConvexHullOverlap.dir/flags.make
CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.o: ../src/convexHullOverlapDetector.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.o -c /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHullOverlapDetector.cc

CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHullOverlapDetector.cc > CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.i

CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/src/convexHullOverlapDetector.cc -o CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.s

# Object files for target removeConvexHullOverlap
removeConvexHullOverlap_OBJECTS = \
"CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.o" \
"CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.o" \
"CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.o" \
"CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.o"

# External object files for target removeConvexHullOverlap
removeConvexHullOverlap_EXTERNAL_OBJECTS =

removeConvexHullOverlap: CMakeFiles/removeConvexHullOverlap.dir/src/main.cc.o
removeConvexHullOverlap: CMakeFiles/removeConvexHullOverlap.dir/src/convexHull.cc.o
removeConvexHullOverlap: CMakeFiles/removeConvexHullOverlap.dir/src/convexHullParser.cc.o
removeConvexHullOverlap: CMakeFiles/removeConvexHullOverlap.dir/src/convexHullOverlapDetector.cc.o
removeConvexHullOverlap: CMakeFiles/removeConvexHullOverlap.dir/build.make
removeConvexHullOverlap: CMakeFiles/removeConvexHullOverlap.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX executable removeConvexHullOverlap"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/removeConvexHullOverlap.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/removeConvexHullOverlap.dir/build: removeConvexHullOverlap

.PHONY : CMakeFiles/removeConvexHullOverlap.dir/build

CMakeFiles/removeConvexHullOverlap.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/removeConvexHullOverlap.dir/cmake_clean.cmake
.PHONY : CMakeFiles/removeConvexHullOverlap.dir/clean

CMakeFiles/removeConvexHullOverlap.dir/depend:
	cd /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build /home/szmlb/workspace/github/code-practice/cpp/convexhull_overlap_detection/build/CMakeFiles/removeConvexHullOverlap.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/removeConvexHullOverlap.dir/depend

