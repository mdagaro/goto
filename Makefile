DIRS := docs src
CLEAN_DIRS := $(addsuffix .clean,$(DIRS))
FORMAT_DIRS := $(addsuffix .format, src)
INSTALL_DIRS := $(addsuffix .install, docs src)
UNINSTALL_DIRS := $(addsuffix .uninstall, docs src)
UPDATE_DIRS := $(addsuffix .update, docs)
GOTO_ALIAS := "alias goto=\". $$GOTO_PATH/goto\""


$(DIRS):
	$(MAKE) -C $@

all: $(DIRS)


$(CLEAN_DIRS):
	$(MAKE) -C $(basename $@) clean

clean: $(CLEAN_DIRS)


$(FORMAT_DIRS):
	$(MAKE) -C $(basename $@) format

format: $(FORMAT_DIRS)


$(INSTALL_DIRS): 
	$(MAKE) -C $(basename $@) install

install: $(INSTALL_DIRS) 


$(UNINSTALL_DIRS): 
	$(MAKE) -C $(basename $@) uninstall

uninstall: $(UNINSTALL_DIRS)


$(UPDATE_DIRS): 
	$(MAKE) -C $(basename $@) update

update: $(UPDATE_DIRS)

.PHONY: all clean install format $(DIRS) $(CLEAN_DIRS) $(INSTALL_DIRS) $(UNINSTAL_DIRS) $(FORMAT_DIRS)  $(UPDATE_DIRS)
