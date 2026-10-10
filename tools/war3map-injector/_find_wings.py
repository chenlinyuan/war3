import sys
sys.path.insert(0, 'tools/war3map-injector')
from parse_w3obj2 import parse

v, o, c = parse(r'maps/伏魔战记.w3x.orig/war3map.w3a')
TARGETS = {'A006', 'A008', 'A004', 'A005', 'A007', 'A009'}
print('=== target abilities ===')
for e in o + c:
    old, new, mods = e[0], e[1], e[2]
    d = {m[0]: m[4] for m in mods}
    if old in TARGETS or new in TARGETS:
        print('=== %s -> %s | anam=%s' % (old, new, d.get('anam')))
        for m in mods:
            print('   %s = %s (lv=%s col=%s)' % (m[0], m[4], m[2], m[3]))
