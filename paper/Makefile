SRC = Structural_Breaks.tex
BIBFILE = $(HOME)/texmf/bibtex/bib/default.bib
JABREF = jabref
BIBTEX = bibtex8
LATEX = pdflatex -interaction batchmode

depends = $(wildcard plots/*.tex) $(wildcard plots/*.pdf)

obj = $(SRC:%.tex=%.pdf)
auxfile = $(SRC:%.tex=%.aux)

all: $(obj)

# makeplots:
# 	#@echo 'did not run plots'
# 	make -C plots

$(obj): $(SRC) $(BIBFILE)
	$(LATEX) $<
	$(JABREF) -n true -a $(auxfile),local.bib $(BIBFILE)
	$(BIBTEX) $(auxfile)
	$(LATEX) $<
	$(LATEX) $<

