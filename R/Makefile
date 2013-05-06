R = R

all: library build

build: build-smgdlm

build-smgdlm: library/smgdlm/DESCRIPTION

library/smgdlm/DESCRIPTION: smgdlm/DESCRIPTION $(wildcard smgdlm/R/*.R)
	$(R) CMD INSTALL --build --library=./library smgdlm	

library:
	-mkdir library
