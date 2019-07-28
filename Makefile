DIRS := docs src
CLEAN_DIRS := $(addsuffix .clean,$(DIRS))
FORMAT_DIRS := $(addsuffix .format, (src))

.PHONY: all clean format

all: $(DIRS)

clean: $(CLEAN_DIRS)

$(DIRS):
	$(MAKE) -C $@

$(CLEAN_DIRS):
	$(MAKE) -C $(basename $@) clean

$(FORMAT_DIRS):
	$(MAKE) -C $(basename $@) format


.PHONY: all clean $(DIRS) $(CLEAN_DIRS)
