R = R

build: build-smgdlm

build-smgdlm: smgdlm/DESCRIPTION $(wildcard smgdlm/R/*.R) library
	$(R) CMD INSTALL --build --library=./library smgdlm	

library:
	-mkdir library
