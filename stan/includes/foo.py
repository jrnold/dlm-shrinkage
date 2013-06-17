import pystache
import itertools

renderer = pystache.Renderer()

keyvals = [(k, [True, False]) for k in ('tv_Z', 'tv_T', 'tv_H', 'tv_RQR', 'tv_c', 'tv_d', 'use_missing')]
vals = [x[1] for x in keyvals]

def render_macro(tv_T, tv_Z, tv_H, tv_RQR, tv_c, tv_d, use_missing):
    tmpl = open('kalman_seq.hstan.mustache', 'r')
    content = {'tv_T' : int(bool(tv_T)), 
               'tv_Z' : int(bool(tv_Z)), 
               'tv_H' : int(bool(tv_H)),
               'tv_RQR' : int(bool(tv_RQR)), 
               'tv_c' : int(bool(tv_c)), 
               'tv_d' : int(bool(tv_d)), 
               'use_missing' : int(bool(use_missing))}
    macrotxt = renderer.render(tmpl.read(), content)
    return macrotxt

with open("kalman_seq.h", "w") as f:
    for i in itertools.product(*vals):
        macrostr = render_macro(*i)
        f.write(macrostr)
        f.write("\n")
    f.write("#define KALMAN_SEQ(y, T, Z, H, RQR, a1, P1, c, d) KALMAN_SEQ_0000000(y, T, Z, H, RQR, a1, P1, c, d)\n\n")
    f.write("#define KALMAN_SEQ_T(y, T, Z, H, RQR, a1, P1, c, d) KALMAN_SEQ_1111110(y, T, Z, H, RQR, a1, P1, c, d)\n\n")
    f.write("#define KALMAN_SEQ_M(y, T, Z, H, RQR, a1, P1, c, d, missing) KALMAN_SEQ_0000001(y, T, Z, H, RQR, c, d, missing)\n\n")
    f.write("#define KALMAN_SEQ_TM(y, T, Z, H, RQR, a1, P1, c, d, missing) KALMAN_SEQ_1111111(y, T, Z, H, RQR, c, d, a1, P1, missing)\n\n")
        
