PROJECTS_ABC_DEPENDENCY := $(BUILD_DIR)/projects/liba/liba.a \
							$(BUILD_DIR)/projects/libb/libb.a \
							$(BUILD_DIR)/projects/libc/libc.so

$(BUILD_DIR)/projects/abc/.PHONY.DEPENDENCY: $(PROJECTS_ABC_DEPENDENCY) ;
