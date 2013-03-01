# Directory of models
DIR = .
STAN_HOME = $(HOME)/remotes/stan/stan-src-1.1.1
# Extension name for compiled objects
EXE = .stanx

# Compiler to use
CC = g++
# Level of optimization
O = 3

# DO NOT EDIT below that line
###################################################################################

# Create objects
source = $(wildcard $(DIR)/*.stan)
# TODO: slash direction would need to be generalized for cross-platform.
objects = $(patsubst %.stan,%$(EXE),$(source))

# TODO: insert OS specific stuff
AR = ar

# Stan Paths
STAN_BIN = $(STAN_HOME)/bin/
STAN_SRC = $(STAN_HOME)/src/
STAN_LIB = $(STAN_HOME)/lib/
STANC = $(STAN_BIN)/stanc

# Library locations
# Kind of robust to version changes 
# and multiple versions (taking one, and usually the last one)
EIGEN ?= $(lastword $(sort $(wildcard $(STAN_LIB)/eigen_*)))
BOOST ?= $(lastword $(sort $(wildcard $(STAN_LIB)/boost_*)))

##
# Set default compiler options.
## 
CFLAGS = -I $(STAN_SRC) -I $(EIGEN) -I $(EIGEN)/unsupported -I $(BOOST) -O$O -fPIC
LDLIBS = -L$(STAN_BIN) -lstan
LDLIBS_STANC = -L$(STAN_BIN) -lstanc

%.cpp : %.stan 
	@echo ''
	@echo '--- Translating Stan graphical model to C++ code ---'
	$(STANC) --name=$(basename $(notdir $<)) --o=$@ $<  

%.o : %.cpp
	@echo ''
	@echo '--- Compiling C++ code ---'
	$(COMPILE.c) $(OUTPUT_OPTION) $<

%$(EXE) : %.o
	@echo ''
	@echo '--- Linking C++ model ---'
	$(LINK.c) $(OUTPUT_OPTION) $< $(LDLIBS)

all: $(objects)
	@echo $(objects)

.SECONDARY:

clean:
	-rm -f $(DIR)/*.cpp $(DIR)/*.stanx $(DIR)/*.o

