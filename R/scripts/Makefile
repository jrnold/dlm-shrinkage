SHELL = bash
DATA_DIR = ../../data/
RDATA_DIR = ../../rdata
RSCRIPT = Rscript

SRC = $(wildcard rdata-*.R)
OBJ = $(SRC:rdata-%.R=$(RDATA_DIR)/%)
DEPS = $(SRC:%.R=%.P)

all: $(DEPS) $(OBJ) hashes.txt

$(RDATA_DIR)/%: rdata-%.R
	$(RSCRIPT) run.R $<

%.P: %.R
	grep "# depends" $< | sed -e 's/#\+ *depends:/rdata-$(<).R:/' > $@

touch-all: 
	touch $(OBJ)

hashes.txt: filehash.R $(OBJ)
	$(RSCRIPT) run.R $< > $@

-include $(SRC:.R=.P)

clean:
	rm -f *.P
