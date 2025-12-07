#!/usr/bin/env python3

import sys
import os

E_SHOFF = 0x28
E_SHNUM = 0x3C
MESSAGE = b"Hello World\n"

if len(sys.argv) < 3:
    print("needs 2 argument, input and output files.")
    exit(1)

with open(sys.argv[1], "rb") as file:
    data = file.read()

end = data.index(MESSAGE) + len(MESSAGE)

data = data[:E_SHOFF] + b"\x00\x00\x00\x00\x00\x00\x00\x00" + data[E_SHOFF + 8:E_SHNUM] + b"\x00\x00\x00\x00" + data[E_SHNUM + 4:end]

with open(sys.argv[2], "wb") as file:
    file.write(data)

os.chmod(sys.argv[2], 0o755)
