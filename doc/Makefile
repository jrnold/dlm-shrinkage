SRC = Structural_Breaks.tex
BIBFILE = $(HOME)/Dropbox/jabref.bib
JABREF = jabref
BIBTEX = bibtex8
LATEX = pdflatex

obj = $(SRC:%.tex=%.pdf)
auxfile = $(SRC:%.tex=%.aux)
plots = $(wildcard plots/*.pdf)

$(obj): $(SRC) $(plots)
	$(LATEX) $^
	$(JABREF) -n -a $(auxfile),local.bib $(BIBFILE)
	$(BIBTEX) $(auxfile)
	$(LATEX) $^
	$(LATEX) $^

