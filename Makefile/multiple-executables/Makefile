# license: CC0

include config.mk

# build dir
BUILD_DIR ?= build

include Makefile.d/main.mk

list-targets:
	@printf '%s\n' $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS) \
		$(SINGLE_SOURCE_LIBRARY_TARGETS) $(SINGLE_SOURCE_EXECUTABLE_TARGETS)

include test.mk
