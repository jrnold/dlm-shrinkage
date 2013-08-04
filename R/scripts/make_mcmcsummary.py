import sys
import random

TEMPLATE = """
# ---
# filehash: mcmcdb_{key}
# ---
set.seed({seed})
KEY <- "{key}"
MCMCDB <- sprintf("mcmcdb_%s", KEY)
MCMCSUMMARY <- sprintf("mcmcsummary_%s", KEY)
RDATA[[MCMCSUMMARY]] <- bsdlm_summary(RDATA[[MCMCDB]], .parallel=TRUE)
"""

if __name__ == '__main__':
    print TEMPLATE.format(seed = random.randint(0,1e8), 
                          key = sys.argv[1])
                
