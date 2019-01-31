#!/usr/bin/env python
import json


def main():
    with open('definitions.json', 'r') as file:
        content = json.load(file)

    for name, list in content.items():
        if list['visible']:
            assert 'title' in list
            assert 'description' in list
        else:
            assert not list['visible']


if __name__ == '__main__':
    main()
