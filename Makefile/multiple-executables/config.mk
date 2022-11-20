# license: CC0

# Rewrite here for your project
LIBRARY_SOURCE_DIRS ?= test/src/libtesta test/src/libtestb
EXECUTABLE_SOURCE_DIRS ?= test/src/test1 test/src/test2
INCLUDE_PATHS ?= test/src/libtesta/include
# single file libraries/executables
LIBRARY_SOURCE_FILES ?= test/src/libtest.cpp
EXECUTABLE_SOURCE_FILES ?= test/src/test3.c test/src/test4.cpp
# build dir
BUILD_DIR ?= build
