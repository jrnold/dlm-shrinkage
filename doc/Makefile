SRC = Structural_Breaks.tex
BIBFILE = $(HOME)/Dropbox/jabref.bib
JABREF = jabref
BIBTEX = bibtex8
LATEX = pdflatex

obj = $(SRC:%.tex=%.pdf)
auxfile = $(SRC:%.tex=%.aux)

$(obj): $(SRC)
	$(LATEX) $^
	$(JABREF) -n -a $(auxfile),local.bib $(BIBFILE)
	$(BIBTEX) $(auxfile)
	$(LATEX) $^
	$(LATEX) $^

