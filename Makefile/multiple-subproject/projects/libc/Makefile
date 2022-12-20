
SOURCE_DIR ?= projects/libc

BUILD_DIR ?= build

all: $(BUILD_DIR)/$(SOURCE_DIR)/libc.so

$(BUILD_DIR)/$(SOURCE_DIR)/libc.so:
	$(CXX) $(LDFLAGS) $(OBJECT_FILES) -shared -o $@



-include test.mk
