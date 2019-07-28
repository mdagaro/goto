PY_FILES := goto.pyc

all: $(PY_FILES)

%.pyc: %.py
	python -m compileall $<

clean:
	rm -rf *.pyc __pycache__

.PHONY: all clean
