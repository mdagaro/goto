PY_FILES := goto.py
PYC_FILES := $(addsuffix .pyc, $(basename $(PY_FILES)))

all: $(PYC_FILES)

%.pyc: %.py
	python3 -m compileall $<

format:
	black $(PY_FILES)

clean:
	rm -rf *.pyc __pycache__

install: all
	sudo cp goto_complete.bash /etc/bash_completion.d/goto
	sudo chmod 644 /etc/bash_completion.d/goto
	touch goto_complete.bash

uninstall: .delete_complete

.delete_complete: 
	sudo rm /etc/bash_completion.d/goto || true

.PHONY: all clean format install uninstall
