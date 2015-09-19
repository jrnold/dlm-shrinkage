"""
Build Stan models from mustache templates
"""
import os
import os.path
import glob
import pystache

INCLUDE_DIR = (".", "includes")

def identity(x):
    return x

if __name__ == "__main__":
    renderer = pystache.Renderer(search_dirs = INCLUDE_DIR, escape = identity)
    templates = [os.path.splitext(x)[0] for x in glob.glob("*.stan.mustache")]
    for tmpl in templates:
        with open(tmpl, 'w') as f:
            f.write(renderer.render_name(tmpl))
        
