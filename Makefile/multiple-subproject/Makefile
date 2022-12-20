# license: CC0

include config.mk

# build dir
BUILD_DIR ?= build

include Makefile.d/main.mk

list-targets:
	@printf '%s\n' $(LIBRARY_TARGETS) $(EXECUTABLE_TARGETS) $(CUSTOM_MAKE_TARGETS)

-include test.mk
