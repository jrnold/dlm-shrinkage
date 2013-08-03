texfile = PolmethXXX.tex
pdffile = $(texfile:%.tex=%.pdf)

LATEX = pdflatex -batch

all: $(pdffile)
	@echo $(texfile)
	@echo $(pdffile)

make-assets: 
	make -C assets

$(pdffile): $(texfile) 
	$(LATEX) $^

$(pdffile): local_level_hs.stanpp example.R beamerthemelocal.sty make-assets
