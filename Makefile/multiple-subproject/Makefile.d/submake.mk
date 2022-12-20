# license: CC0

# processed on sub make execution

TARGET_NAME := $(TARGET:%.a=%)
TARGET_NAME_ON_SOURCE_DIR := $(TARGET_NAME:$(BUILD_DIR)/%=%)
SOURCE_DIR := $(dir $(TARGET_NAME_ON_SOURCE_DIR))

LIBRARY_NAME := $(TARGET_NAME_ON_SOURCE_DIR)
LIBRARY_FILE := $(LIBRARY_NAME:%=%.a)
EXECUTABLE_FILE := $(TARGET_NAME_ON_SOURCE_DIR)

-include $(CUSTOM_MAKE_FILE)

$(TARGET):

# In shell function, escaping is needed as same as shell script.
SOURCE_FILES := $(shell set -x; find "$(SOURCE_DIR)" -name \*.c -or -name \*.cpp)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/%.o)

include Makefile.d/common.mk
