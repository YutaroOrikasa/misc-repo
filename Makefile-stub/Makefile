# license: CC0

# reference: https://spin.atomicobject.com/2016/08/26/makefile-c-projects/

# Rewrite here for your project
SOURCE_DIRS ?= test/src
INCLUDE_PATHS ?= test/include
EXECUTABLE_FILE ?= main
BUILD_DIR ?= build

# In shell function, escaping is needed sa same as shell script.
SOURCE_FILES := $(shell find $(SOURCE_DIRS) -name \*.c -or -name \*.cpp)

# string replacement
# e.g aaa -> $(BUILD_DIR)/aaa.o
# % maches 'aaa' in example.
OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/%.o)
DEPENDENCY_FILES := $(OBJECT_FILES:%.o=%.d)

_DEP_FLAGS := -MMD -MP
INCLUDE_FLAGS := $(INCLUDE_PATHS:%=-I%)
override CFLAGS += -Wall $(INCLUDE_FLAGS) $(_DEP_FLAGS)
override CXXFLAGS += -Wall -std=c++17 $(INCLUDE_FLAGS) $(_DEP_FLAGS)

all: $(BUILD_DIR)/$(EXECUTABLE_FILE)

# link
$(BUILD_DIR)/$(EXECUTABLE_FILE): $(OBJECT_FILES)
	mkdir -p $(BUILD_DIR)
	$(CXX) $(LDFLAGS) $(OBJECT_FILES) -o $@

# C file
$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -c

# C++ file
$(BUILD_DIR)/%.cpp.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $< -o $@ -c

.PHONY: run clean print-source-files

run: $(BUILD_DIR)/$(EXECUTABLE_FILE)
	$(BUILD_DIR)/$(EXECUTABLE_FILE)

clean:
	rm -rf build

print-source-files:
	@echo $(SOURCE_FILES)

-include $(DEPENDENCY_FILES)
