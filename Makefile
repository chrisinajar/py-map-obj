

SHELL = /bin/sh

ROOT=$(shell pwd)
TESTENV=${ROOT}/.test-env
DIST=${ROOT}/dist/
VENV=${ROOT}/.virtualenv
VENV2=${ROOT}/.virtualenv2
PYPACKAGES=$(shell cat $(ROOT)/requirements.source | tr '\n' ' ')

.PHONY: python
python: $(VENV)/.stamp-h
.PHONY: pip
pip: $(VENV)/.stamp-pip-install-h
.PHONY: freeze
freeze: requirements.txt
.PHONY: test
test: $(VENV)/.stamp-pip-install-h $(VENV2)/.stamp-pip-install-h
	source '${VENV}'/bin/activate && unit2 discover -v
	source '${VENV2}'/bin/activate && unit2 discover -v

.PHONY: publish
publish: test test-package $(DIST)
	twine upload $(DIST)/*py3*
	twine upload $(DIST)/*py2*

.PHONY: clean-package
clean-package:
	- rm -rf $(DIST)
	- rm -rf $(TESTENV)
	- rm -rf $(ROOT)/*.egg-info

.PHONY: build
build: clean-package pip setup.py $(DIST)
.PHONY: package
package: build $(TESTENV)
	source '${TESTENV}'/bin/activate && python
.PHONY: test-package
test-package: build $(TESTENV)
	source '${TESTENV}'/bin/activate && unit2 discover -v

$(DIST): $(VENV)/.stamp-pip-install-h $(VENV2)/.stamp-pip-install-h
	source '${VENV}'/bin/activate && python setup.py bdist_wheel
	source '${VENV2}'/bin/activate && python setup.py bdist_wheel

$(TESTENV): $(DIST)
	virtualenv $(TESTENV) --python=python3
	source '${TESTENV}'/bin/activate && pip install $(DIST)/*py3* unittest2


.PHONY: clean-pip
clean-pip: $(VENV)/.stamp-h
	source '${VENV}'/bin/activate && pip freeze | xargs pip uninstall
	rm -rf $(VENV)/.stamp-pip-install-h

requirements.txt: $(VENV)/.stamp-h requirements.source Makefile
	source '${VENV}'/bin/activate && pip install $(PYPACKAGES) && pip freeze > requirements.txt

$(VENV)/.stamp-h:
	rm -rf "${VENV}"
	mkdir -p "${VENV}"
	virtualenv "${VENV}" --python=python3
	touch "$@"

$(VENV)/.stamp-pip-install-h: $(VENV)/.stamp-h
	source '${VENV}'/bin/activate && pip install -r requirements.txt
	touch "$@"

$(VENV2)/.stamp-h:
	rm -rf "${VENV2}"
	mkdir -p "${VENV2}"
	virtualenv "${VENV2}" --python=python2
	touch "$@"

$(VENV2)/.stamp-pip-install-h: $(VENV2)/.stamp-h
	source '${VENV2}'/bin/activate && pip install -r requirements.txt
	touch "$@"
