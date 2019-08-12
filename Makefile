DIRS := docs src
CLEAN_DIRS := $(addsuffix .clean, $(DIRS))
FORMAT_DIRS := $(addsuffix .format, src)
INSTALL_DIRS := $(addsuffix .install, docs src)
UNINSTALL_DIRS := $(addsuffix .uninstall, docs src)
UPDATE_DIRS := $(addsuffix .update, docs)
LINT_DIRS := $(addsuffix .update, src)
GOTO_ALIAS := "alias goto=\". $$GOTO_PATH/goto\""


all: lint $(DIRS)

.PHONY: $(DIRS) all
$(DIRS):
	$(MAKE) -C $@ all


clean: $(CLEAN_DIRS)

.PHONY: $(CLEAN_DIRS) clean
$(CLEAN_DIRS):
	$(MAKE) -C $(basename $@) clean


format: $(FORMAT_DIRS)

.PHONY: $(FORMAT_DIRS) format
$(FORMAT_DIRS):
	$(MAKE) -C $(basename $@) format


install: $(INSTALL_DIRS) 

.PHONY: $(INSTALL_DIRS) install
$(INSTALL_DIRS): 
	$(MAKE) -C $(basename $@) install


uninstall: $(UNINSTALL_DIRS)

.PHONY: $(UNINSTALL_DIRS) uninstall
$(UNINSTALL_DIRS): 
	$(MAKE) -C $(basename $@) uninstall


update: $(UPDATE_DIRS)

.PHONY: $(UPDATE_DIRS) update
$(UPDATE_DIRS): 
	$(MAKE) -C $(basename $@) update

lint: $(LINT_DIRS)

.PHONY: $(LINT_DIRS) lint
$(LINT_DIRS): 
	$(MAKE) -C $(basename $@) lint

