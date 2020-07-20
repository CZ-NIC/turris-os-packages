#!/usr/bin/env python
"""Generate pot (translations template) file for definitions. It expects an
path to output file as an first argument.
"""
import os
import sys
import json
import datetime
import polib

DEFS = "./definitions.json"
OUT = sys.argv[1]


if not os.path.isfile(DEFS):
    print("Missing file: " + DEFS)
    exit(1)


# Initialize PO file
po = polib.POFile()
po.metadata = {
    'Project-Id-Version': 'userlists',
    'Report-Msgid-Bugs-To': 'packaging@turris.cz',
    'POT-Creation-Date':
        datetime.datetime.now().strftime('%Y-%m-%d %H:%M%z'),
    'PO-Revision-Date':
        datetime.datetime.now().strftime('%Y-%m-%d %H:%M%z'),
    'MIME-Version': '1.0',
    'Content-Type': 'text/plain; charset=utf-8',
    'Content-Transfer-Encoding': '8bit',
}

# Fill it
with open(DEFS, 'r') as file:
    content = json.load(file)

for name, lst in content.items():
    if 'title' in lst:
        po.append(polib.POEntry(
            msgid=lst['title'],
            msgstr=u'',
            occurrences=[(DEFS, '')]
        ))
    if 'description' in lst:
        po.append(polib.POEntry(
            msgid=lst['description'],
            msgstr=u'',
            occurrences=[(DEFS, '')]
        ))

# Merge with previous version
if os.path.isfile(OUT):
    existing_po = polib.pofile(OUT)
    existing_po.merge(po)
    po = existing_po

# Save new version
po.save(OUT)
