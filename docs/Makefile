DOCS1 := goto.1
DOCS := $(DOCS1)
UPDATE_FILE := .make-update
MAN1_DIR := /usr/local/share/man/man1/

all: $(DOCS)

%.1: %.man
	asciidoctor -b manpage $<

# Install the man files in /usr/local/share/man/...
update: .make-update

install: all
	make -B .make-update
	# Update the man function to include these functions. These should only
	# need to be run once or when a new endpoint is created.
	sudo mandb
	touch .make-install

uninstall:
	for file in $(DOCS1); do \
		sudo rm "/usr/local/share/man/man1/$$file" || true; \
	done

.make-update: $(DOCS)
	for file in $?; do \
		sudo cp "$$file" /usr/local/share/man/man1/; \
	done
	touch .make-update

.PHONY: all clean uninstall install

clean:
	rm -f *.1
