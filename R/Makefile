R = R

all: library build

build: build-bsdlm

build-bsdlm: library/bsdlm/DESCRIPTION

library/bsdlm/DESCRIPTION: bsdlm/DESCRIPTION $(wildcard bsdlm/R/*.R)
	$(R) CMD INSTALL --build --library=./library bsdlm

library:
	-mkdir library
