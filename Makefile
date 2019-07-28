DIRS := docs src
CLEAN_DIRS := $(addsuffix .clean,$(DIRS))

.PHONY: all clean

all: $(DIRS)

clean: $(CLEAN_DIRS)

$(DIRS):
	$(MAKE) -C $@

$(CLEAN_DIRS):
	$(MAKE) -C $(basename $@) clean

.PHONY: all clean $(DIRS) $(CLEAN_DIRS)
