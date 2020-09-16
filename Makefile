# We use make for testing purposes only.
#-$(PYTHON) setup.py clean --all # ignore errors from this command

PYTHON=python3
PURE=
export LANGUAGE=C
export LC_ALL=C

help:
	@echo 'We use make for testing purposes. Below are some common targets:'
	@echo
	@echo '  all          - the same as the "tests" target.'
	@echo '  tests        - run all tests in the automatic test suite.'
	@echo '  test-foo.t   - run only specified tests (in this case, test-foo.t)'
	@echo '  clean        - remove files created by other targets'
	@echo
	@echo 'All tests are in the tests/ directory. To run these tests individually,'
	@echo 'just execute `make <test-file-name>`, where <test-file-name> should not'
	@echo 'have the dir prefix: "test/", e.g., `make test-hgflow-basic.t`.'
	@echo
	@echo 'To alter how testings are conducted, you can set the TESTFLAGS. For'
	@echo 'example, if you want to run tests parallelly, you can execute'
	@echo 'something like:'
	@echo '  make TESTFLAGS="-j 2" tests'
	@echo 'which will run 2 tests simultaneously. To see a list of options that'
	@echo 'you can set for TESTFLAGS, execute `make TESTFLAGS="-h" tests`.'

all: tests

clean:
	find tests \( -name '*.py[cdo]' -o -name '*.so' \) -exec rm -f '{}' ';'
	rm -f $(addprefix mercurial/,$(notdir $(wildcard mercurial/pure/[a-z]*.py)))
	rm -f MANIFEST MANIFEST.in mercurial/__version__.py hgext/__index__.py tests/*.err

check: tests

tests:
	cd tests && $(PYTHON) run-tests.py $(TESTFLAGS)

test-%:
	cd tests && $(PYTHON) run-tests.py $(TESTFLAGS) $@

.PHONY: clean \
	tests \

