SHELL = bash
DATA_DIR = ../../data
RDATA_DIR = ../../rdata
STAN_DIR = ../../stan
RSCRIPT = Rscript

SRC = $(wildcard rdata-*.R)
OBJ = $(SRC:rdata-%.R=$(RDATA_DIR)/%)

all: dependencies $(OBJ) hashes.txt

$(RDATA_DIR)/%: rdata-%.R
	$(RSCRIPT) run.R $<

dependencies:
	python configure.py > dependencies.inc

touch-all: 
	touch $(OBJ)

hashes.txt: filehash.R $(OBJ)
	$(RSCRIPT) run.R $< > $@

-include dependencies.inc

.PHONY: dependencies

clean:
	rm dependencies.inc
