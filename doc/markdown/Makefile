export PATH := $(HOME)/.cabal/bin:$(PATH)
PANDOC = pandoc
BIBFILE = $(HOME)/Dropbox/jabref.bib

notes.pdf : notes.md
	#	$(PANDOC) -M biblio-files=$(BIBFILE) --biblatex -s -o $@ $^
	$(PANDOC) --bibliography=$(BIBFILE) -o $@ $^
