#!/usr/bin/env python3

import os
import struct
import sys
import subprocess
import random
import time
import re

FORMAT = "Q"
SIZE   = struct.calcsize(FORMAT)
MAX    = 1 << 16

IN_FILE    = "unsorted.b"
OUT_FILE = "sorted.b"

def make_in_file(inFile, count):
    output = []
    with open(inFile, "wb") as file:
        for i in range(count):
            value = random.randrange(0, MAX)
            file.write(struct.pack(FORMAT, value))
            output.append(value)

    return output

VALGRID = ["valgrind", "--tool=memcheck", "--leak-check=yes", "--verbose"]
def run_sort(sortType, inFile, outFile, doValgrid):
    args = ["./main", sortType, inFile, outFile]
    if doValgrid:
        args = VALGRID + [f"--log-file=mem.log"] + args
    start = time.time()
    subprocess.Popen(args).wait()
    end = time.time()

    return end - start

IS_SORTED     = 0
FILE_TO_SHORT = 1
NOT_SORTED    = 2

def check_sorted(filename, values):
    with open(filename, "rb") as file:
        for i, value in enumerate(values):
            data = file.read(SIZE)
            if len(data) != SIZE:
                return FILE_TO_SHORT, i
            current, = struct.unpack(FORMAT, data)
            if current != value:
                return NOT_SORTED, i

    return IS_SORTED, len(values)

TIME_FORMAT = ".5f"

def print_results(isSorted, numSorted, time, numElem, doValgrid):
    if isSorted == FILE_TO_SHORT:
        print(f"Only had {numSorted} / {numElem} elements in {time:{TIME_FORMAT}}s.")
    elif isSorted == NOT_SORTED:
        print(f"Only had {numSorted} / {numElem} elements sorted correctly in {time:{TIME_FORMAT}}s.")
    else:
        print(f"Fully sorted, ({numSorted} / {numElem}) elements in {time:{TIME_FORMAT}}s.")

    if (doValgrid):
        with open(f"mem.log") as file:
            if ("All heap blocks were freed -- no leaks are possible" in file.read()):
                print(f"Had no memory leaks.")
            else:
                print(f"HAS memory leaks.")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        sys.stderr.write("First argument must be number of items to use.\n")
        exit(-1)

    try:
        numElem = int(sys.argv[1])
    except:
        sys.stderr.write( "First argument must be number of items to use.\n")
        sys.stderr.write(f'    "{sysargv[1]}" could not be converted to an int.\n')
        exit(-1)

    if numElem < 1:
        sys.stderr.write( "First argument must be number of items to use.\n")
        sys.stderr.write(f'    "{numElem}" must be at least 1.\n')
        exit(-1)

    doValgrid = "-v" in sys.argv

    values = sorted(make_in_file(IN_FILE, numElem))

    print("Starting sort.")
    sortTime = run_sort("-l", IN_FILE, OUT_FILE, doValgrid)
    isSorted, numSorted = check_sorted(OUT_FILE, values)
    print_results(isSorted, numSorted, sortTime, numElem, doValgrid)

    sortTime = run_sort("-m", IN_FILE, OUT_FILE, doValgrid)
    isSorted, numSorted = check_sorted(OUT_FILE, values)
    print_results(isSorted, numSorted, sortTime, numElem, doValgrid)

    exit(0)
