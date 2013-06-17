"""
Parse headers of each R file and generate Makefile dependencies.
"""
import re
import glob
import os.path

import yaml

HEADER_LINE = re.compile("# ---")

def strip_comments(line):
    return re.sub("^#+ *", "", line)

def get_header(filename):
    with open(filename, 'r') as f:
        header = []
        inheader = False
        for line in f:
            if inheader:
                if HEADER_LINE.match(line):
                    break
                else:
                    header.append(strip_comments(line))
            else:
                if HEADER_LINE.match(line):
                    inheader = True
    return yaml.load(''.join(header))

def get_key(filename):
    return re.sub("^rdata-", "$(RDATA_DIR)/",
                  os.path.splitext(os.path.basename(filename))[0])

def make_dependencies(filename):
    header = get_header(filename)
    key = get_key(filename)
    dependencies = [filename]
    if header:
        if 'rdata' in header:
            if isinstance(header['rdata'], str):
                dependencies.append("$(RDATA_DIR)/%s" % header['rdata'])
            else:
                for x in header['rdata']:
                    dependencies.append("$(RDATA_DIR)/%s" % x)
        if 'stan' in header:
            if isinstance(header['stan'], str):
                dependencies.append("$(STAN_DIR)/%s" % header['stan'])
            else:
                for x in header['stan']:
                    dependencies.append("$(STAN_DIR)/%s" % x)
        if 'data' in header:
            if isinstance(header['data'], str):
                dependencies.append("$(DATA_DIR)/%s" % header['data'])
            else:
                for x in header['data']:
                    dependencies.append("$(DATA_DIR)/%s" % x)
        if 'scripts' in header:
            if isinstance(header['scripts'], str):
                dependencies.append(header['scripts'])
            else:
                for x in header['scripts']:
                    dependencies.append(x)
    return "%s: %s \n" % (key, ' '.join(dependencies))

if __name__ == '__main__':
    for filename in glob.glob("rdata-*.R"):
        print make_dependencies(filename)

