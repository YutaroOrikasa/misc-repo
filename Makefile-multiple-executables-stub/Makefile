# license: CC0

# Rewrite here for your project
LIBRARY_SOURCE_DIRS ?= test/src/testlib
INCLUDE_PATHS ?= test/include
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

all: $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS)
# Go to
# $(BUILD_DIR)/%.a:
# $(BUILD_DIR)/%:
# rules.

##### begin sub make #####
# processed on recursive make execution
# TARGET is empty in top make.
# TARGET is passed on launching sub make via command line argument.
TARGET_NAME := $(TARGET:%.a=%)
SOURCE_DIR := $(TARGET_NAME:$(BUILD_DIR)/%=%)

LIBRARY_NAME := $(SOURCE_DIR)
LIBRARY_FILE := $(LIBRARY_NAME:%=%.a)
EXECUTABLE_FILE := $(SOURCE_DIR)

# In shell function, escaping is needed sa same as shell script.
# find command will be done in sub make (== TARGET is not empty).
SOURCE_FILES := $(shell test -n "$(TARGET)" && find "$(SOURCE_DIR)" -name \*.c -or -name \*.cpp)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/sub/%.o)
DEPENDENCY_FILES := $(OBJECT_FILES:%.o=%.d)

.PHONY: sub
sub: $(TARGET)

$(BUILD_DIR)/$(LIBRARY_NAME).a: $(OBJECT_FILES)
	mkdir -p $(@D)
	ar rsc $@ $(OBJECT_FILES)

$(BUILD_DIR)/$(EXECUTABLE_FILE): $(OBJECT_FILES)
	mkdir -p $(@D)
	$(CXX) $(LDFLAGS) $(OBJECT_FILES) $(LIBRARY_TARGETS) -o $@

# C file
$(BUILD_DIR)/sub/%.c.o: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -c

# C++ file
$(BUILD_DIR)/sub/%.cpp.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $< -o $@ -c

##### end sub make #####

# Top level rules must be at after sub make rules
# otherwise some/file.cpp.o matches $(BUILD_DIR)/%: rule.
# The order of rule definition is important.

$(BUILD_DIR)/%.a:
	$(MAKE) TARGET=$(@) sub

# This dummy rule is needed because
# -include $(DEPENDENCY_FILES) directive adds DEPENDENCY_FILES to targets,
# This dummy rule prevents that DEPENDENCY_FILES matches $(BUILD_DIR)/% target.
$(BUILD_DIR)/%.d:
	true

$(BUILD_DIR)/%: $(LIBRARY_TARGETS)
	$(MAKE) TARGET=$(@) sub


# PHONY targets
.PHONY: clean test-make

clean:
	rm -rf build

test-make:
	$(MAKE) clean
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	cp -p $(BUILD_DIR)/test/src/test1 $(BUILD_DIR)/test/src/test1.old
	touch test/src/testlib/testlib.h
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	test -n "$(find $(BUILD_DIR) -name $(BUILD_DIR)/test/src/test1 -newer $(BUILD_DIR)/test/src/test1.old)"


-include $(DEPENDENCY_FILES)
