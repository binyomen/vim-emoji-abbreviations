#!/usr/bin/env python

# Use emoji data from https://github.com/iamcal/emoji-data.

import json
import os
import urllib.request

INPUT_URL = 'https://raw.githubusercontent.com/iamcal/emoji-data/master/emoji.json'
OUTPUT_FILE = os.path.join(os.path.dirname(__file__), 'lua', 'vim-emoji-abbreviations', 'emoji.lua')

def unified_to_string(unified):
    code_point_strings = unified.split('-')
    code_points = map(lambda s: int('0x' + s, base = 16), code_point_strings)

    s = ''
    for code_point in code_points:
        s += chr(code_point)

    return s

def main():
    short_names = []
    with urllib.request.urlopen(INPUT_URL) as input_file:
        emoji_list = json.loads(input_file.read())
        for emoji in emoji_list:
            character = unified_to_string(emoji['unified'])
            for short_name in emoji['short_names']:
                short_names.append((short_name, character))

    with open(OUTPUT_FILE, 'wb') as output_file:
        output_file.write('return {\n'.encode('utf8'))
        for short_name, character in sorted(short_names):
            colon_name = f':{short_name}:'

            # Vim doesn't seem to support abbreviations that are longer than 52
            # characters.
            if len(colon_name) <= 52:
                label = f'{colon_name} {character}'
                line_string = (f"    " +
                    f"{{word = '{colon_name}', " +
                    f"label = '{label}', " +
                    f"filterText = '{colon_name}', " +
                    f"character = '{character}'}},\n")

                output_file.write(line_string.encode('utf8'))
        output_file.write('}\n'.encode('utf8'))

if __name__ == '__main__':
    main()
