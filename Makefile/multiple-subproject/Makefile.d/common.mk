# license: CC0

# Either LIBRARY_NAME or EXECUTABLE_FILE must be given.

# In shell function, escaping is needed as same as shell script.
SOURCE_FILES := $(shell set -x; find "$(SOURCE_DIR)" -name \*.c -or -name \*.cpp)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/%.o)

# C file
$(BUILD_DIR)/%.c.o: %.c
	mkdir -p $(@D)
	$(CC) $(CFLAGS) $< -o $@ -c

# C++ file
$(BUILD_DIR)/%.cpp.o: %.cpp
	mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) $< -o $@ -c


$(BUILD_DIR)/$(LIBRARY_NAME).a: $(OBJECT_FILES)
	mkdir -p $(@D)
	ar rsc $@ $(OBJECT_FILES)

$(BUILD_DIR)/$(EXECUTABLE_FILE): $(OBJECT_FILES)
	mkdir -p $(@D)
	$(CXX) $(LDFLAGS) $(OBJECT_FILES) $(LIBRARY_FILES) -o $@


DEPENDENCY_FILES := $(OBJECT_FILES:%.o=%.d)
-include $(DEPENDENCY_FILES)
