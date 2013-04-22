SRC = Structural_Breaks.tex
BIBFILE = $(HOME)/Dropbox/jabref.bib
JABREF = jabref
BIBTEX = bibtex8

pdffile = $(SRC:%.tex=%.pdf)

LATEX = pdflatex

$(obj): $(texfile) macros.tex $(tikzfiles)
	$(LATEX) $^
	$(JABREF) -n -a $(auxfile),acw_markets_2.bib $(BIBFILE)
	$(BIBTEX) $(auxfile)
	$(LATEX) $^
	$(LATEX) $^

Structural_Breaks.pdf: Structural_Breaks.tex
	$(LATEX) $^
