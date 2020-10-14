# license: CC0

# string replacement
# e.g aaa -> $(BUILD_DIR)/aaa.o
# % maches 'aaa' in example.
SINGLE_SOURCE_LIBRARY_TARGETS := $(addsuffix .a, $(basename $(LIBRARY_SOURCE_FILES:%=$(BUILD_DIR)/%)))
SINGLE_SOURCE_EXECUTABLE_TARGETS := $(basename $(EXECUTABLE_SOURCE_FILES:%=$(BUILD_DIR)/%))

ALL_LIBRARY_TARGETS := $(SINGLE_SOURCE_LIBRARY_TARGETS) $(LIBRARY_TARGETS)


_DEP_FLAGS := -MMD -MP
INCLUDE_FLAGS := $(INCLUDE_PATHS:%=-I%)
override CFLAGS += -Wall $(INCLUDE_FLAGS) $(_DEP_FLAGS)
override CXXFLAGS += -Wall -std=c++17 $(INCLUDE_FLAGS) $(_DEP_FLAGS)

export CFLAGS
export CXXFLAGS


all: $(SINGLE_SOURCE_LIBRARY_TARGETS) $(SINGLE_SOURCE_EXECUTABLE_TARGETS)

# .PHONY: $(EXECUTABLE_SOURCE_FILES:%=$(BUILD_DIR)/_db/%)
$(EXECUTABLE_SOURCE_FILES:%=$(BUILD_DIR)/_db/%):
	mkdir -p $(@D)
	printf '%s\n' $(@:$(BUILD_DIR)/_db/%=%) > $(basename $(@))

# .PHONY: $(LIBRARY_SOURCE_FILES:%=$(BUILD_DIR)/_db/%)
$(LIBRARY_SOURCE_FILES:%=$(BUILD_DIR)/_db/%):
	mkdir -p $(@D)
	printf '%s\n' $(@:$(BUILD_DIR)/_db/%=%) > $(basename $(@)).a

_make_db: \
		$(EXECUTABLE_SOURCE_FILES:%=$(BUILD_DIR)/_db/%) \
		$(LIBRARY_SOURCE_FILES:%=$(BUILD_DIR)/_db/%) \
		;

$(SINGLE_SOURCE_LIBRARY_TARGETS): _make_db FORCE
	@echo SINGLE LIB $@
	$(MAKE) -f Makefile.d/submake.mk TARGET=$(@) BUILD_DIR=$(BUILD_DIR)

$(SINGLE_SOURCE_EXECUTABLE_TARGETS): $(ALL_LIBRARY_TARGETS) _make_db FORCE
	@echo SINGLE $@
	$(MAKE) -f Makefile.d/submake.mk TARGET=$(@) \
		LIBRARY_TARGETS="$(ALL_LIBRARY_TARGETS)" BUILD_DIR=$(BUILD_DIR)

# We must always do submake because main makefile can't detect depending file updated,
# so we put FORCE dummy target.
FORCE: ;

# PHONY targets
.PHONY: clean list-targets test

clean:
	rm -rf build
