# license: CC0

# Rewrite here for your project
LIBRARY_SOURCE_DIRS ?= test/src/testlib
INCLUDE_PATHS ?= test/include
EXECUTABLE_SOURCE_DIRS ?= test/src/test1 test/src/test2
BUILD_DIR ?= build

# string replacement
# e.g aaa -> $(BUILD_DIR)/aaa.o
# % maches 'aaa' in example.
LIBRARY_FILES := $(LIBRARY_SOURCE_DIRS:%=$(BUILD_DIR)/%.L)
EXECUTABLE_FILES := $(EXECUTABLE_SOURCE_DIRS:%=$(BUILD_DIR)/%.E)


_DEP_FLAGS := -MMD -MP
INCLUDE_FLAGS := $(INCLUDE_PATHS:%=-I%)
override CFLAGS += -Wall $(INCLUDE_FLAGS) $(_DEP_FLAGS)
override CXXFLAGS = -Wall -std=c++17 $(INCLUDE_FLAGS) $(_DEP_FLAGS)

all: $(LIBRARY_FILES) $(EXECUTABLE_FILES)

$(BUILD_DIR)/%.L:
	$(MAKE) BUILD_DIR=$(BUILD_DIR) LIBRARY_TARGET=$@ sub

$(BUILD_DIR)/%.E:
	$(MAKE) BUILD_DIR=$(BUILD_DIR) TARGET=$@ sub


# processed on recursive make execution
LIBRARY_SOURCE_DIR := $(LIBRARY_TARGET:$(BUILD_DIR)/%.L=%)
EXECUTABLE_SOURCE_DIR := $(TARGET:$(BUILD_DIR)/%.E=%)

LIBRARY_NAME := $(LIBRARY_SOURCE_DIR)
LIBRARY_FILE := $(LIBRARY_NAME:%=%.a)
EXECUTABLE_FILE := $(EXECUTABLE_SOURCE_DIR)
SOURCE_DIR := $(LIBRARY_SOURCE_DIR)$(EXECUTABLE_SOURCE_DIR)

# In shell function, escaping is needed sa same as shell script.
SOURCE_FILES := $(shell test -n "$(SOURCE_DIR)" && find "$(SOURCE_DIR)" -name \*.c -or -name \*.cpp)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/sub/%.o)
DEPENDENCY_FILES := $(OBJECT_FILES:%.o=%.d)

.PHONY: sub
sub: $(LIBRARY_FILE:%=$(BUILD_DIR)/%) $(EXECUTABLE_FILE:%=$(BUILD_DIR)/%)

$(BUILD_DIR)/$(LIBRARY_NAME).a: $(OBJECT_FILES)
	mkdir -p $(@D)
	ar rsc $@ $(OBJECT_FILES)

$(BUILD_DIR)/$(EXECUTABLE_FILE): $(OBJECT_FILES)
	mkdir -p $(@D)
	$(CC) $(LDFLAGS) $(OBJECT_FILES) $(LIBRARY_FILES:%.L=%.a) -o $@

# C file
$(BUILD_DIR)/sub/%.c.o: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -c

# C++ file
$(BUILD_DIR)/sub/%.cpp.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $< -o $@ -c


# PHONY targets
.PHONY: clean print-source-files

clean:
	rm -rf build

print-source-files:
	@echo $(SOURCE_FILES)

-include $(DEPENDENCY_FILES)
