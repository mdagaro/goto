PY_FILES := goto.py
PYC_FILES := $(addsuffix .pyc, $(basename $(PY_FILES)))

all: $(PYC_FILES)

%.pyc: %.py
	python3 -m compileall $<

format:
	black $(PY_FILES)

clean:
	rm -rf *.pyc __pycache__

.PHONY: all clean format
