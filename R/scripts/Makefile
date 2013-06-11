SHELL = bash
DATA_DIR = ../../data/
RDATA_DIR = ../../rdata
RSCRIPT = Rscript

SRC = $(wildcard rdata-*.R)
OBJ = $(SRC:rdata-%.R=$(RDATA_DIR)/%)
DEPS = $(SRC:%.R=%.P)

all: $(DEPS)

makedepends:
	$(PYTHON) makedepends.py

$(RDATA_DIR)/%: rdata-%.R
	$(RSCRIPT) run.R $<

%.P: %.R
	@grep "# depends" $< | sed -e 's/#\+ *depends:/$<:/' > $@

-include $(SRC:.R=.P)
