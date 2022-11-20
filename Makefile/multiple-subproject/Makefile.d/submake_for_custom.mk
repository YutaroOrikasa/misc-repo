# license: CC0

# In shell function, escaping is needed as same as shell script.
SOURCE_FILES := $(shell find "$(SOURCE_DIR)" -name \*.c -or -name \*.cpp)

OBJECT_FILES := $(SOURCE_FILES:%=$(BUILD_DIR)/%.o)

include Makefile.d/common.mk
