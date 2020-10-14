# license: CC0

# Rewrite here for your project
INCLUDE_PATHS ?= test/src/include
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
	./build/test/src/test3
	./build/test/src/test4

test-make:
	$(MAKE) clean
	$(MAKE) all
	$(BUILD_DIR)/test/src/test3
	cp -p $(BUILD_DIR)/test/src/test3 $(BUILD_DIR)/test/src/test3.old
	$(MAKE) test
	sleep 1
	touch test/src/include/libtest.h
	$(MAKE) all
	$(BUILD_DIR)/test/src/test3
	test -n "$$(find $(BUILD_DIR) -path $(BUILD_DIR)/test/src/test3 -newer $(BUILD_DIR)/test/src/test3.old)"
