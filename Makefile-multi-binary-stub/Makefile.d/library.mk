# processed on sub make execution
TARGET_NAME := $(TARGET:%.a=%)

include Makefile.d/common.mk

$(BUILD_DIR)/$(LIBRARY_NAME).a: $(OBJECT_FILES)
	mkdir -p $(@D)
	ar rsc $@ $(OBJECT_FILES)
