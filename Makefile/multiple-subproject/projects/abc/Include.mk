include projects/abc/Dependency.mk

$(BUILD_DIR)/projects/abc/abc: $(PROJECTS_ABC_DEPENDENCY)
	$(MAKE) -f projects/abc/Makefile \
		DEFAULT_MAKERULE_FILE=Makefile.d/submake_for_custom.mk \
		SOURCE_DIR=projects/abc \
		TARGET=$(@)
		BUILD_DIR=$(BUILD_DIR)
