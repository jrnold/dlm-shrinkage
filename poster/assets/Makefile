PLOTS = $(patsubst %.R,%.pdf,$(wildcard fig-*.R))
TABLES = $(patsubst %.R,%.tex,$(wildcard tab-*.R))
CODE = code-local_level_hs.tex

RSCRIPT = Rscript

all: build-figs build-tables

build-figs: $(PLOTS)

build-tables: $(TABLES)

code-%.tex: ../../../stan/%.stanpp
	@echo $< $@
	$(PYGMENTIZE) -O style=bw -l stan -f latex -o $@ $<

fig-%.pdf: fig-%.R conf.R
	$(RSCRIPT) $< $@

tab-%.tex: tab-%.R conf.R
	$(RSCRIPT) $< $@

fig-nile1.R fig-nile2.R fig-nile3.R: .nile_fit_plot.R
