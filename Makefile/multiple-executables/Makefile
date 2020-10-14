# license: CC0

# Rewrite here for your project
LIBRARY_SOURCE_DIRS ?= test/src/libtesta test/src/libtestb
EXECUTABLE_SOURCE_DIRS ?= test/src/test1 test/src/test2
INCLUDE_PATHS ?= test/src/libtesta/include
# single file libraries/executables
LIBRARY_SOURCE_FILES ?= test/src/libtest.c
EXECUTABLE_SOURCE_FILES ?= test/src/test3.c test/src/test4.cpp
# build dir
BUILD_DIR ?= build

include Makefile.d/main.mk

list-targets:
	@printf '%s\n' $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS) \
		$(SINGLE_SOURCE_LIBRARY_TARGETS) $(SINGLE_SOURCE_EXECUTABLE_TARGETS)

test:
	./build/test/src/test1
	./build/test/src/test2
	./build/test/src/test3
	./build/test/src/test4

test-make:
	$(MAKE) clean
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	cp -p $(BUILD_DIR)/test/src/test1 $(BUILD_DIR)/test/src/test1.old
	$(MAKE) test
	sleep 1
	touch test/src/libtesta/include/libtesta.h
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	test -n "$$(find $(BUILD_DIR) -path $(BUILD_DIR)/test/src/test1 -newer $(BUILD_DIR)/test/src/test1.old)"
