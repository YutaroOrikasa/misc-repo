
# processed on sub make execution

SOURCE_DIR := $(TARGET_NAME:$(BUILD_DIR)/%=%)

LIBRARY_NAME := $(SOURCE_DIR)
LIBRARY_FILE := $(LIBRARY_NAME:%=%.a)
EXECUTABLE_FILE := $(SOURCE_DIR)

# In shell function, escaping is needed sa same as shell script.
SOURCE_FILES := $(shell find "$(SOURCE_DIR)" -name \*.c -or -name \*.cpp)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/sub/%.o)




# C file
$(BUILD_DIR)/sub/%.c.o: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -c

# C++ file
$(BUILD_DIR)/sub/%.cpp.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $< -o $@ -c




DEPENDENCY_FILES := $(OBJECT_FILES:%.o=%.d)
-include $(DEPENDENCY_FILES)
