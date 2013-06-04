R = R

all: library build

build: build-sddlm

build-sddlm: library/sddlm/DESCRIPTION

library/sddlm/DESCRIPTION: sddlm/DESCRIPTION $(wildcard sddlm/R/*.R)
	$(R) CMD INSTALL --build --library=./library sddlm

library:
	-mkdir library
