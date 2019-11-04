#!/usr/bin/env python
import os
import sys
import json
import datetime
import argparse
import polib
from schema import Schema, Optional, Regex

DEFINITIONS = 'definitions.json'


def definitions():
    """Load pkglists definitions.
    """
    with open(os.path.join(os.path.dirname(__file__), DEFINITIONS)) as file:
        return json.load(file)


def po_add_string(po, string):
    """Add given string to PO file.
    """
    po.append(polib.POEntry(
        msgid=string,
        msgstr=u'',
        occurrences=[(DEFINITIONS, '')]
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
        po_add_string(po, lst['title'])
        po_add_string(po, lst['description'])
        if 'options' in lst:
            for _, opt in lst['options'].items():
                po_add_string(po, opt['title'])
                po_add_string(po, opt['description'])
    if os.path.isfile(args.OUTPUT):
        po.merge(polib.pofile(args.OUTPUT))
    po.save(args.OUTPUT)


def op_verify(_):
    """verify operation implementation to check schema of definitions.json
    """
    schema = Schema({
        Regex(r'^\w+$'): {
            'title': str,
            'description': str,
            Optional('url'): str,
            Optional('official'): bool,
            Optional('options'): {
                Regex(r'^\w+$'): {
                    'title': str,
                    'description': str,
                    Optional('default'): bool,
                }
            }
        }
    })
    schema.validate(definitions())


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
