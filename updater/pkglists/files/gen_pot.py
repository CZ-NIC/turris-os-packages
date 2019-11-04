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
    'Project-Id-Version': 'pkglists',
    'Report-Msgid-Bugs-To': 'packaging@turris.cz',
    'POT-Creation-Date':
        datetime.datetime.now().strftime('%Y-%m-%d %H:%M%z'),
    'PO-Revision-Date':
        datetime.datetime.now().strftime('%Y-%m-%d %H:%M%z'),
    'MIME-Version': '1.0',
    'Content-Type': 'text/plain; charset=utf-8',
    'Content-Transfer-Encoding': '8bit',
}


def add_string(string):
    """Add given string to PO file.
    """
    po.append(polib.POEntry(
        msgid=string,
        msgstr=u'',
        occurrences=[(DEFS, '')]
    ))


# Fill it
with open(DEFS, 'r') as file:
    content = json.load(file)


for name, lst in content.items():
    add_string(lst['title'])
    add_string(lst['description'])
    if 'options' in lst:
        for opt in lst['options']:
            add_string(opt['title'])
            add_string(opt['description'])


# Merge with previous version
if os.path.isfile(OUT):
    po.merge(polib.pofile(OUT))

# Save new version
po.save(OUT)
