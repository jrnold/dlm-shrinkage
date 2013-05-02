SRC = Structural_Breaks.tex
BIBFILE = $(HOME)/texmf/bibtex/bib/default.bib
JABREF = jabref
BIBTEX = bibtex8
LATEX = pdflatex -interaction batchmode

obj = $(SRC:%.tex=%.pdf)
auxfile = $(SRC:%.tex=%.aux)
plots = $(wildcard plots/*.pdf)

all: $(obj)

makeplots:
	make -C plots

$(obj): $(SRC) $(plots) $(BIBFILE) makeplots
	$(LATEX) $<
	$(JABREF) -n -a $(auxfile),local.bib $(BIBFILE)
	$(BIBTEX) $(auxfile)
	$(LATEX) $<
	$(LATEX) $<

