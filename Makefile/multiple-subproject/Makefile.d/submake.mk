# license: CC0

# processed on sub make execution

TARGET_NAME := $(TARGET:%.a=%)
SOURCE_DIR := $(TARGET_NAME:$(BUILD_DIR)/%=%)

LIBRARY_NAME := $(SOURCE_DIR)
LIBRARY_FILE := $(LIBRARY_NAME:%=%.a)
EXECUTABLE_FILE := $(SOURCE_DIR)

all: $(TARGET)

# In shell function, escaping is needed as same as shell script.
SOURCE_FILES := $(shell if [ "$(SINGLE_SOURCE)" = 1 ];then \
	find . -path ./"$(SOURCE_DIR)".c -or -path ./"$(SOURCE_DIR)".cpp; \
else \
	find "$(dir $(SOURCE_DIR))" -name \*.c -or -name \*.cpp; \
fi)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/%.o)

include Makefile.d/common.mk
