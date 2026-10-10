import re, collections

p = r'H:\Games\War3\ojzrqpjb\share\mpq\units\units\abilitymetadata.slk'
t = open(p, encoding='latin-1').read()

# find the AIad ability and its data fields (Had1 etc.)
for aid in ['AIad', 'AHad', 'AIda']:
    i = t.find('K"%s"' % aid)
    print('===', aid, 'idx', i)
    if i > 0:
        print(t[i - 100:i + 300].replace('\n', ' | '))

# find Had1 field definition
i = t.find('K"Had1"')
print('=== Had1 field ===')
if i > 0:
    print(t[i - 300:i + 300].replace('\n', ' | '))
