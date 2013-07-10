SRC = Structural_Breaks.tex
BIBFILE = $(HOME)/texmf/bibtex/bib/default.bib
JABREF = jabref
BIBTEX = bibtex8
LATEX = pdflatex -interaction batchmode
ROOTDIR = ../../

depends = $(wildcard plots/*.tex) $(wildcard plots/*.pdf)

obj = $(SRC:%.tex=%.pdf)
auxfile = $(SRC:%.tex=%.aux)

all: $(obj)

Rlibs:
	make -C $(ROOTDIR)/R/

makeplots: Rlibs
	make -C assets

$(obj): $(SRC) $(BIBFILE) local.sty pygments.tex #makeplots Rlibs 
	$(LATEX) $<
	#$(JABREF) -n true -a $(auxfile),local.bib $(BIBFILE)
	$(BIBTEX) $(auxfile)
	$(LATEX) $<
	$(LATEX) $<

