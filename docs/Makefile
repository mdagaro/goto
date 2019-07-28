DOCS1 := goto.1 goto-add.1 goto-delete.1 goto-list.1 goto-get.1
DOCS := $(DOCS1)
UPDATE_FILE := .make-update

all: $(DOCS)

%.1: %.man
	asciidoctor -b manpage $<

# Install the man files in /usr/local/share/man/...
update: .make-update

install: .make-install

.make-update: $(DOCS)
	for file in $?; do \
		sudo cp "$$file" /usr/local/share/man/man1/; \
	done
	touch .make-update

.make-install: .make-update
	touch .make-install
	# Update the man function to include these functions. These should only
	# need to be run once or when a new endpoint is created.
	sudo mandb

.PHONY: all clean install

clean:
	rm -f *.1
