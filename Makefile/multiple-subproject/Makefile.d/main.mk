# license: CC0

# string replacement
# e.g aaa -> $(BUILD_DIR)/aaa.o
# % maches 'aaa' in example.
LIBRARY_TARGETS := $(foreach dir, $(LIBRARY_SOURCE_DIRS), $(BUILD_DIR)/$(dir)/$(notdir $(dir)).a)
EXECUTABLE_TARGETS := $(foreach dir, $(EXECUTABLE_SOURCE_DIRS), $(BUILD_DIR)/$(dir)/$(notdir $(dir)))
CUSTOM_MAKE_TARGETS := $(foreach dir, $(CUSTOM_MAKE_SOURCE_DIRS), $(BUILD_DIR)/$(dir)/$(notdir $(dir)))

ALL_LIBRARY_TARGETS := $(LIBRARY_TARGETS)


_DEP_FLAGS := -MMD -MP
INCLUDE_FLAGS := $(INCLUDE_PATHS:%=-I%)
override CFLAGS += -Wall $(INCLUDE_FLAGS) $(_DEP_FLAGS)
override CXXFLAGS += -Wall -std=c++17 $(INCLUDE_FLAGS) $(_DEP_FLAGS)

export CFLAGS
export CXXFLAGS

include $(CUSTOM_MAKE_SOURCE_DIRS:%=%/Include.mk)


all: $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS) $(CUSTOM_MAKE_TARGETS) ;


$(BUILD_DIR)/%.a: FORCE
	$(MAKE) -f Makefile.d/submake.mk TARGET=$(@) BUILD_DIR=$(BUILD_DIR) all



$(BUILD_DIR)/%/___: FORCE $(BUILD_DIR)/%/._____.DEPENDENCY
	$(MAKE) -f $(@:$(BUILD_DIR)/%/.PHONY=%/Makefile) DEFAULT_MAKERULE_FILE=Makefile.d/submake_for_custom.mk SOURCE_DIR=$(@:$(BUILD_DIR)/%/.PHONY=%) TARGET=$(@) BUILD_DIR=$(BUILD_DIR)

$(BUILD_DIR)/%: $(ALL_LIBRARY_FILES) FORCE
	$(MAKE) -f Makefile.d/submake.mk LIBRARY_FILES="$(ALL_LIBRARY_TARGETS)" TARGET=$(@) BUILD_DIR=$(BUILD_DIR) all

# We must always do submake because main makefile can't detect depending file updated,
# so we put FORCE dummy target.
FORCE: ;

# PHONY targets
.PHONY: clean list-targets test

clean:
	rm -rf build
