PLOTS = $(patsubst %.R,%.pdf,$(wildcard fig-*.R))
TABLES = $(patsubst %.R,%.tex,$(wildcard tab-*.R))
CODE = code-normal.tex code-horseshoe.tex

RSCRIPT = Rscript
PYGMENTIZE = pygmentize

all: build-pygments build-figs build-tables

build-pygments: $(CODE)

build-figs: $(PLOTS)

build-tables: $(TABLES)

code-%.tex: ../../stan/models/%.stan
	$(PYGMENTIZE) -O style=bw -f latex -o $@ $<

fig-%.pdf: fig-%.R conf.R
	$(RSCRIPT) $< $@

tab-%.tex: tab-%.R conf.R
	$(RSCRIPT) $< $@

