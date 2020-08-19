# processed on sub make execution
TARGET_NAME := $(TARGET:%=%)

include Makefile.d/common.mk

$(BUILD_DIR)/$(EXECUTABLE_FILE): $(OBJECT_FILES)
	mkdir -p $(@D)
	$(CXX) $(LDFLAGS) $(OBJECT_FILES) $(LIBRARY_TARGETS) -o $@
