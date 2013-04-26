SRC = horseshoe1.pdf horseshoe2.pdf
PDF = $(SRC:%.R=%.pdf)
RSCRIPT = Rscript

all: $(SRC)

%.pdf: %.R
	$(RSCRIPT) $^

