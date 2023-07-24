#!/bin/sh
filepath=$1
filename=$(basename "$filepath")
mkdir -p ./outputs/runtime/
mkdir -p ./outputs/svg
time -o ./outputs/runtime/"${filename%.png}.txt" ./autotrace -centerline -background-color FFFFFF -output-file ./outputs/svg/"${filename%.png}.svg" "$filepath"
