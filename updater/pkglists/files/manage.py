#!/usr/bin/env python
import os
import sys
import json
import datetime
import argparse
import polib
from schema import Schema, Optional, Regex, Or

DEFINITIONS = 'definitions.json'
LABELS = 'labels.json'

BOARDS = ("mox", "omnia", "turris1x")


def definitions():
    """Load pkglists definitions.
    """
    with open(os.path.join(os.path.dirname(__file__), DEFINITIONS)) as file:
        return json.load(file)


def labels():
    """Load package list labels.
    """
    with open(os.path.join(os.path.dirname(__file__), LABELS)) as file:
        return json.load(file)


def po_add_string(po, string, occurance):
    """Add given string to PO file.
    """
    po.append(polib.POEntry(
        msgid=string,
        msgstr=u'',
        occurrences=[(occurance, '')]
    ))


def op_pot(args):
    """pot operation implementation (to generate POT file)
    """
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
    for _, lst in definitions().items():
        po_add_string(po, lst['title'], DEFINITIONS)
        po_add_string(po, lst['description'], DEFINITIONS)
        if 'options' in lst:
            for _, opt in lst['options'].items():
                po_add_string(po, opt['title'], DEFINITIONS)
                po_add_string(po, opt['description'], DEFINITIONS)
    for _, lbl in labels().items():
        po_add_string(po, lbl['title'], LABELS)
        po_add_string(po, lbl['description'], LABELS)
    if os.path.isfile(args.OUTPUT):
        existing_po = polib.pofile(args.OUTPUT)
        existing_po.merge(po)
        po = existing_po
    po.save(args.OUTPUT)


def op_verify(_):
    """verify operation implementation to check schema of definitions.json and labels.json
    """
    schema_labels = Schema({
        Regex(r'^\w+$'): {
            'title': str,
            'description': str,
            'severity': Or("danger", "warning", "info", "success", "primary", "secondary", "light", "dark")
        }
    })
    lbls = labels()
    schema_labels.validate(lbls)

    schema_definitions = Schema({
        Regex(r'^\w+$'): {
            'title': str,
            'description': str,
            Optional('url'): str,
            Optional('labels'): list(lbls.keys()),
            Optional('boards'): list(BOARDS),
            Optional('options'): {
                Regex(r'^\w+$'): {
                    'title': str,
                    'description': str,
                    Optional('url'): str,
                    Optional('labels'): list(lbls.keys()),
                    Optional('boards'): list(BOARDS),
                    Optional('default'): bool,
                }
            }
        }
    })
    schema_definitions.validate(definitions())


OPERATIONS = {
    "pot": op_pot,
    "verify": op_verify,
}


def main():
    parser = argparse.ArgumentParser(description="Management script for pkglists definitions")
    subparsers = parser.add_subparsers()

    pot = subparsers.add_parser('pot', help='Generate POT file for localizations')
    pot.set_defaults(op='pot')
    pot.add_argument('OUTPUT', help='Path to output POT file')

    verify = subparsers.add_parser('verify', help='Verify against schema')
    verify.set_defaults(op='verify')

    args = parser.parse_args()
    if 'op' in args:
        OPERATIONS[args.op](args)
    else:
        parser.print_usage()
        sys.exit(1)


if __name__ == '__main__':
    main()
