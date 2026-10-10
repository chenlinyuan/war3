import sys
sys.path.insert(0, 'tools/war3map-injector')
from parse_w3obj2 import parse

# w3t items
v, o, c = parse(r'maps/伏魔战记.w3x.orig/war3map.w3t')
print('=== w3t items (orig %d custom %d) ===' % (len(o), len(c)))
for e in o + c:
    old, new, mods = e[0], e[1], e[2]
    d = {m[0]: m[4] for m in mods}
    print('%s -> %s | unam=%s | iabi=%s | ifil=%s | iico=%s' % (
        old, new, d.get('unam'), d.get('iabi'), d.get('ifil'), d.get('iico')))
