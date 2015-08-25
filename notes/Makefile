PANDOC = pandoc
BIBFILE = $(HOME)/Dropbox/jabref.bib

notes.pdf : notes.md
	$(PANDOC) --bibliography=$(BIBFILE) -o $@ $^
