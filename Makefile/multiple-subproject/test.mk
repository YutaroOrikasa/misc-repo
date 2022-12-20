# license: CC0

test: all
	build/projects/a/a
	build/projects/x/x
	build/projects/req-libreqa/req-libreqa
	build/projects/abc/abc

test-make:
	$(MAKE) clean
	$(MAKE) all
	build/projects/a/a
	cp -p build/projects/a/a build/projects/a/a.old
	$(MAKE) test
	sleep 1
	touch projects/liba/liba.hpp
	$(MAKE) all
	build/projects/a/a
	test -n "$$(find $(BUILD_DIR) -path build/projects/a/a -newer build/projects/a/a.old)"
