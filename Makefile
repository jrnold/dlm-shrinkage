SRC = Structural_Breaks.md
OBJ = $(SRC:%.md=%.pdf)

all: $(OBJ)

%.pdf: %.md
	pandoc -f markdown -o $@ $^
