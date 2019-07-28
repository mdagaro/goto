DIRS := docs src
CLEAN_DIRS := $(addsuffix .clean,$(DIRS))
FORMAT_DIRS := $(addsuffix .format, src)
INSTALL_DIRS := $(addsuffix .install, docs)
GOTO_ALIAS := "alias goto=\". $$GOTO_PATH/goto\""

.PHONY: all clean format

all: $(DIRS)

clean: $(CLEAN_DIRS)

install: all $(INSTALL_DIRS) /etc/bash_completion.d/goto

format: $(FORMAT_DIRS)

$(DIRS):
	$(MAKE) -C $@

$(CLEAN_DIRS):
	$(MAKE) -C $(basename $@) clean

$(FORMAT_DIRS):
	$(MAKE) -C $(basename $@) format

$(INSTALL_DIRS): 
	$(MAKE) -C $(basename $@) install

/etc/bash_completion.d/goto: src/goto_complete.bash
	sudo cp ./src/goto_complete.bash /etc/bash_completion.d/goto
	sudo chmod 644 /etc/bash_completion.d/goto

.PHONY: all clean install format $(DIRS) $(CLEAN_DIRS) $(INSTALL_DIRS)
