#!/usr/bin/env python
import json


def main():
    with open('definitions.json', 'r') as file:
        content = json.load(file)

    for name, list in content.items():
        if list['visible'] == 'yes':
            assert 'title' in list
            assert 'description' in list
        else:
            assert list['visible'] == 'no'


if __name__ == '__main__':
    main()
