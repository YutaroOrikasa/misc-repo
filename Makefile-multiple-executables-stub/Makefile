# license: CC0

# Rewrite here for your project
LIBRARY_SOURCE_DIRS ?= test/src/testlib
INCLUDE_PATHS ?= test/include
EXECUTABLE_SOURCE_DIRS ?= test/src/test1 test/src/test2
BUILD_DIR ?= build

# string replacement
# e.g aaa -> $(BUILD_DIR)/aaa.o
# % maches 'aaa' in example.
LIBRARY_DUMMY_TARGETS := $(LIBRARY_SOURCE_DIRS:%=$(BUILD_DIR)/%._L)
EXECUTABLE_DUMMY_TARGETS := $(EXECUTABLE_SOURCE_DIRS:%=$(BUILD_DIR)/%._E)


_DEP_FLAGS := -MMD -MP
INCLUDE_FLAGS := $(INCLUDE_PATHS:%=-I%)
override CFLAGS += -Wall $(INCLUDE_FLAGS) $(_DEP_FLAGS)
override CXXFLAGS += -Wall -std=c++17 $(INCLUDE_FLAGS) $(_DEP_FLAGS)

all: $(LIBRARY_DUMMY_TARGETS) $(EXECUTABLE_DUMMY_TARGETS)

$(BUILD_DIR)/%._L:
	$(MAKE) TARGET=$(@:%._L=%.a) sub

$(BUILD_DIR)/%._E:
	$(MAKE) TARGET=$(@:%._E=%) sub


# processed on recursive make execution

TARGET_NAME := $(TARGET:%.a=%)
SOURCE_DIR := $(TARGET_NAME:$(BUILD_DIR)/%=%)

LIBRARY_NAME := $(SOURCE_DIR)
LIBRARY_FILE := $(LIBRARY_NAME:%=%.a)
EXECUTABLE_FILE := $(SOURCE_DIR)

# In shell function, escaping is needed sa same as shell script.
SOURCE_FILES := $(shell test -n "$(SOURCE_DIR)" && find "$(SOURCE_DIR)" -name \*.c -or -name \*.cpp)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/sub/%.o)
DEPENDENCY_FILES := $(OBJECT_FILES:%.o=%.d)

.PHONY: sub
sub: $(TARGET)

$(BUILD_DIR)/$(LIBRARY_NAME).a: $(OBJECT_FILES)
	mkdir -p $(@D)
	ar rsc $@ $(OBJECT_FILES)

$(BUILD_DIR)/$(EXECUTABLE_FILE): $(OBJECT_FILES)
	mkdir -p $(@D)
	$(CXX) $(LDFLAGS) $(OBJECT_FILES) $(LIBRARY_DUMMY_TARGETS:%._L=%.a) -o $@

# C file
$(BUILD_DIR)/sub/%.c.o: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -c

# C++ file
$(BUILD_DIR)/sub/%.cpp.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $< -o $@ -c


# PHONY targets
.PHONY: clean

clean:
	rm -rf build

-include $(DEPENDENCY_FILES)
