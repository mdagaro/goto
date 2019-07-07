DOCS1 := goto.1 goto-add.1 goto-delete.1 goto-list.1 goto-refresh.1 goto-help.1
DOCS := $(DOCS1)

all: $(DOCS)

%.1: %.man
	asciidoctor -b manpage $<


# Install the man files in /usr/local/share/man/...
update: $(DOCS)
	for file in $(DOCS1); do \
		sudo cp "./$$file" /usr/local/share/man/man1/; \
	done


install: $(DOCS)
	$(MAKE) update
	# Update the man function to include these functions. These should only
	# need to be run once or when a new endpoint is created.
	sudo mandb


.PHONY: all clean install

clean:
	rm -f *.1
