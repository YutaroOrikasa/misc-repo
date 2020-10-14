# license: CC0

# string replacement
# e.g aaa -> $(BUILD_DIR)/aaa.o
# % maches 'aaa' in example.
LIBRARY_TARGETS := $(LIBRARY_SOURCE_DIRS:%=$(BUILD_DIR)/%.a)
EXECUTABLE_TARGETS := $(EXECUTABLE_SOURCE_DIRS:%=$(BUILD_DIR)/%)
SINGLE_SOURCE_LIBRARY_TARGETS := $(addsuffix .a, $(basename $(LIBRARY_SOURCE_FILES:%=$(BUILD_DIR)/%)))
SINGLE_SOURCE_EXECUTABLE_TARGETS := $(basename $(EXECUTABLE_SOURCE_FILES:%=$(BUILD_DIR)/%))

ALL_LIBRARY_TARGETS := $(SINGLE_SOURCE_LIBRARY_TARGETS) $(LIBRARY_TARGETS)


_DEP_FLAGS := -MMD -MP
INCLUDE_FLAGS := $(INCLUDE_PATHS:%=-I%)
override CFLAGS += -Wall $(INCLUDE_FLAGS) $(_DEP_FLAGS)
override CXXFLAGS += -Wall -std=c++17 $(INCLUDE_FLAGS) $(_DEP_FLAGS)

export CFLAGS
export CXXFLAGS


all: $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS) \
	$(SINGLE_SOURCE_LIBRARY_TARGETS) $(SINGLE_SOURCE_EXECUTABLE_TARGETS)



$(BUILD_DIR)/_single_source_target_list.txt: FORCE
	mkdir -p $(@D)
	printf '%s\n' $(LIBRARY_SOURCE_FILES) $(EXECUTABLE_SOURCE_FILES) \
		>$(BUILD_DIR)/_single_source_target_list.txt

$(BUILD_DIR)/_multiple_source_target_list.txt: FORCE
	mkdir -p $(@D)
	printf '%s\n' $(LIBRARY_SOURCE_DIRS) $(EXECUTABLE_SOURCE_DIRS) \
		>$(BUILD_DIR)/_multiple_source_target_list.txt

$(BUILD_DIR)/_db/%: \
					$(BUILD_DIR)/_single_source_target_list.txt \
					$(BUILD_DIR)/_multiple_source_target_list.txt \
					FORCE
	mkdir -p $(@D)
	grep $(basename $(@:$(BUILD_DIR)/_db/%=%)) $(BUILD_DIR)/_single_source_target_list.txt > $(@) || \
		grep $(basename $(@:$(BUILD_DIR)/_db/%=%)) $(BUILD_DIR)/_multiple_source_target_list.txt > $(@)





$(BUILD_DIR)/%.a: $(BUILD_DIR)/_db/%.a FORCE
	$(MAKE) -f Makefile.d/submake.mk TARGET=$(@) BUILD_DIR=$(BUILD_DIR)

$(BUILD_DIR)/%: $(ALL_LIBRARY_TARGETS) $(BUILD_DIR)/_db/% FORCE
	$(MAKE) -f Makefile.d/submake.mk TARGET=$(@) LIBRARY_TARGETS="$(ALL_LIBRARY_TARGETS)" BUILD_DIR=$(BUILD_DIR)

# We must always do submake because main makefile can't detect depending file updated,
# so we put FORCE dummy target.
FORCE: ;

# PHONY targets
.PHONY: clean list-targets test

clean:
	rm -rf build
