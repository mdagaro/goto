DOCS1 := goto.1 goto-add.1 goto-delete.1 goto-list.1 goto-refresh.1
DOCS := $(DOCS1)

all: $(DOCS)

%.1: %.man
	asciidoctor -b manpage $<

# Install the man files in /usr/local/share/man/...
install: $(DOCS)
	for file in $(DOCS1); do \
		sudo cp "./$$file" /usr/local/share/man/man1/; \
	done
	sudo mandb


.PHONY: all clean install

clean:
	rm -f $(DOCS)
