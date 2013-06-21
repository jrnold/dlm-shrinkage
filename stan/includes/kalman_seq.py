import sys
import itertools

import pystache

renderer = pystache.Renderer()


def render_macro(tmpl, tv_T, tv_Z, tv_H, tv_RQR, tv_c, tv_d, use_missing):
    content = {'tv_T' : bool(tv_T),
               'tv_Z' : bool(tv_Z), 
               'tv_H' : bool(tv_H),
               'tv_RQR' : bool(tv_RQR),
               'tv_c' : bool(tv_c), 
               'tv_d' : bool(tv_d),
               'tv' : tv_T or tv_Z or tv_H or tv_RQR or tv_c or tv_d,
               'use_missing' : bool(use_missing)}
    macrotxt = renderer.render(tmpl.read(), content)
    return macrotxt

if __name__ == '__main__':
    tmplate = sys.argv[1]
    keyvals = [(k, [True, False]) for k in ('tv_Z', 'tv_T', 'tv_H', 'tv_RQR', 'tv_c', 'tv_d', 'use_missing')]
    vals = [x[1] for x in keyvals]
    print("#define TRANSPOSE '\n\n")
    for i in itertools.product(*vals):
        macrostr = render_macro(open(tmplate, 'r'), *i)
        print(macrostr + "\n")
