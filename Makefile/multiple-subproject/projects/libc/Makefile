
SOURCE_DIR ?= .

BUILD_DIR ?= build

$(BUILD_DIR)/$(SOURCE_DIR)/libc.so: $(BUILD_DIR)/$(SOURCE_DIR)/libc.a
	$(CXX) $(LDFLAGS) $< -shared -o $@

LIBRARY_NAME := $(SOURCE_DIR)/libc
include $(DEFAULT_MAKERULE_FILE)
