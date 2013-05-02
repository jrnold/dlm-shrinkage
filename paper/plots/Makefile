PLOTS = $(patsubst %.R,%.pdf,$(wildcard fig-*.R))
RSCRIPT = Rscript

all: $(PLOTS)

fig-%.pdf: fig-%.R conf.R
	$(RSCRIPT) $< $@

