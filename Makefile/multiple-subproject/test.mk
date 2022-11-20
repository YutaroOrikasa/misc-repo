# license: CC0

test:
	./build/test/src/test1
	./build/test/src/test2
	./build/test/src/test3
	./build/test/src/test4

test-make:
	$(MAKE) clean
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	cp -p $(BUILD_DIR)/test/src/test1 $(BUILD_DIR)/test/src/test1.old
	$(MAKE) test
	sleep 1
	touch test/src/libtesta/include/libtesta.h
	$(MAKE) all
	$(BUILD_DIR)/test/src/test1
	test -n "$$(find $(BUILD_DIR) -path $(BUILD_DIR)/test/src/test1 -newer $(BUILD_DIR)/test/src/test1.old)"
