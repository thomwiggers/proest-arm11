#!/usr/bin/env python3
"""
Very quick and really dirty macro expansion
"""


import sys
import re

filename = sys.argv[1]

# import expression
import_statement = re.compile(r'#@import\((?P<filename>.+?)\)')


def read_file(filename):
    with open(filename, 'r') as f:
        file_contents = f.read()
    return file_contents

file_contents = read_file(filename)

for line in file_contents.splitlines():
    match = import_statement.search(line)
    if match:
        print(import_statement.sub(
            line, read_file(match.group('filename'))))
    else:
        print(line)
