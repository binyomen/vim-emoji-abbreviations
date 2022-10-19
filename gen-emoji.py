#!/usr/bin/env python

# Use emoji data from https://github.com/iamcal/emoji-data.

import json
import os

THIS_DIR = os.path.dirname(__file__)
INPUT_FILE = os.path.join(THIS_DIR, 'emoji.json')
OUTPUT_FILE = os.path.join(THIS_DIR, 'lua', 'vim-emoji-abbreviations', 'emoji.lua')

def unified_to_string(unified):
    code_point_strings = unified.split('-')
    code_points = map(lambda s: int('0x' + s, base = 16), code_point_strings)

    s = ''
    for code_point in code_points:
        s += chr(code_point)

    return s

def main():
    short_names = {}
    with open(INPUT_FILE, 'r') as input_file:
        emoji_list = json.loads(input_file.read())
        for emoji in emoji_list:
            character = unified_to_string(emoji['unified'])
            for short_name in emoji['short_names']:
                short_names[short_name] = character

    with open(OUTPUT_FILE, 'wb') as output_file:
        output_file.write('return {\n'.encode('utf8'))
        for short_name in sorted(short_names):
            # Vim doesn't seem to support abbreviations that are longer than 52
            # characters (including the two colons added later).
            if len(short_name) <= 50:
                output_file.write(f"    ['{short_name}'] = '{short_names[short_name]}',\n".encode('utf8'))
        output_file.write('}\n'.encode('utf8'))

if __name__ == '__main__':
    main()
