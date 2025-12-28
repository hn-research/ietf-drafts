# Makefile for RFCXML I-Draft
DRAFT = draft-goswami-agentic-jwt
VERSION = 00
XML_SOURCE = $(DRAFT)-$(VERSION).xml
TXT_OUTPUT = $(DRAFT)-$(VERSION).txt
HTML_OUTPUT = $(DRAFT)-$(VERSION).html

.PHONY: all txt html watch clean

all: txt html

txt: $(TXT_OUTPUT)
html: $(HTML_OUTPUT)

$(TXT_OUTPUT): $(XML_SOURCE)
	@echo "Building TXT..."
	@xml2rfc $< --text -o $@
	@echo " TXT created: $@"

$(HTML_OUTPUT): $(XML_SOURCE)
	@echo "Building HTML..."
	@xml2rfc $< --html -o $@
	@echo " HTML created: $@"

watch:
	@echo "  Watching for changes..."
	@while true; do make html 2>/dev/null; sleep 2; done

clean:
	@rm -f $(TXT_OUTPUT) $(HTML_OUTPUT)
	@echo " Clean complete"
