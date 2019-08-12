PY_FILES := goto.py
PYC_FILES := $(addsuffix .pyc, $(basename $(PY_FILES)))

.PHONY: all
all: $(PYC_FILES)

%.pyc: %.py
	python3 -m compileall $<

.PHONY: format
format:
	black $(PY_FILES)

.PHONY: clean
clean:
	rm -rf *.pyc __pycache__

.PHONY: install
install: all
	sudo cp goto_complete.bash /etc/bash_completion.d/goto
	sudo chmod 644 /etc/bash_completion.d/goto
	touch goto_complete.bash

.PHONY: uninstall
uninstall: .delete_complete

.delete_complete: 
	sudo rm /etc/bash_completion.d/goto || true


.PHONY: lint
lint: .pyflakes .mypy

.pyflakes:
	pyflakes $(PY_FILES)

.mypy:
	mypy $(PY_FILES)
