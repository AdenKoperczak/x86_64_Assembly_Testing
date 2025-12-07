#!/bin/bash

make

generate=1
lsb=1
msb=1
shell=1

diff_lsb_msb=1
diff_lsb_shell=0
diff_msb_shell=0

if [ $generate != 0 ]; then
    echo "Generator"
    time ./generator $1
fi

if [ $? == 0 ]; then
    if [ $lsb != 0 ]; then
        echo $'\n''LSB'
        time ./main -l unsortedRadix.b sortedRadixLSB.b
    fi

    if [ $msb != 0 ]; then
        echo $'\n''MSB'
        time ./main -m unsortedRadix.b sortedRadixMSB.b
    fi

    if [ $shell != 0 ]; then
        echo $'\n''Shell'
        time ./pa1 -a unsortedShell.b sortedShell.b
    fi


    if [ $((diff_lsb_msb * lsb * msb)) != 0 ]; then
        echo $'\n''Diff LSB and MSB'
        diff sortedRadixLSB.b sortedRadixMSB.b
    fi

    if [ $((diff_lsb_shell * lsb * shell)) != 0 ]; then
        echo $'\n''Diff LSB and Shell'
        diff sortedRadixLSB.b sortedShell.b
    fi

    if [ $((diff_msb_shell * msb * shell)) != 0 ]; then
        echo $'\n''Diff MSB and Shell'
        diff sortedRadixMSB.b sortedShell.b
    fi
fi
