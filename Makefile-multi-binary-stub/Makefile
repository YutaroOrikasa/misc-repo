# license: CC0

# Rewrite here for your project
LIBRARY_SOURCE_DIRS ?= test/src/libtesta test/src/libtestb
INCLUDE_PATHS ?= test/src/libtesta/include
EXECUTABLE_SOURCE_DIRS ?= test/src/test1 test/src/test2
BUILD_DIR ?= build

# string replacement
# e.g aaa -> $(BUILD_DIR)/aaa.o
# % maches 'aaa' in example.
LIBRARY_TARGETS := $(LIBRARY_SOURCE_DIRS:%=$(BUILD_DIR)/%.a)
EXECUTABLE_TARGETS := $(EXECUTABLE_SOURCE_DIRS:%=$(BUILD_DIR)/%)


_DEP_FLAGS := -MMD -MP
INCLUDE_FLAGS := $(INCLUDE_PATHS:%=-I%)
override CFLAGS += -Wall $(INCLUDE_FLAGS) $(_DEP_FLAGS)
override CXXFLAGS += -Wall -std=c++17 $(INCLUDE_FLAGS) $(_DEP_FLAGS)

export CFLAGS
export CXXFLAGS

all: $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS)


$(BUILD_DIR)/%.a: FORCE
	$(MAKE) -f Makefile.d/submake.mk TARGET=$(@) BUILD_DIR=$(BUILD_DIR)

$(BUILD_DIR)/%: FORCE
	$(MAKE) -f Makefile.d/submake.mk TARGET=$(@) LIBRARY_TARGETS="$(LIBRARY_TARGETS)" BUILD_DIR=$(BUILD_DIR)

FORCE: ;

# PHONY targets
.PHONY: clean list-targets test

clean:
	rm -rf build

list-targets:
	@printf '%s\n' $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS)

test:
	./build/test/src/test1
	./build/test/src/test2

test-make:
	$(MAKE) clean
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	cp -p $(BUILD_DIR)/test/src/test1 $(BUILD_DIR)/test/src/test1.old
	touch test/src/libtesta/include/libtesta.h
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	test -n "$(find $(BUILD_DIR) -name $(BUILD_DIR)/test/src/test1 -newer $(BUILD_DIR)/test/src/test1.old)"
