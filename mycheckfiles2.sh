#!/bin/bash

echo "Number of hkl files"
find . -name "*.hkl" | grep -v -e spiketrain -e mountains | wc -l

echo "Number of mda files"
find mountains -name "firings.mda" | wc -l

echo -e "\n#==========================================================="
echo "Start Times"
for file in *.out; do
    # Extract the first occurrence of time.struct_time from each *.out file
    echo "==> $file <=="
    awk '/time.struct_time/ {print; exit}' $file
    echo ""
done

echo "End Times"
for file in *.out; do
    # Extract the last occurrence of time.struct_time, the time taken, and the MessageId from each *.out file
    echo "==> $file <=="
    awk '/time.struct_time/ {last=$0} END {print last}' $file
    tail -4 $file | head -1
    echo "{"
    tail -2 $file | head -1
    echo "}"
    echo ""
done
echo "#==========================================================="
