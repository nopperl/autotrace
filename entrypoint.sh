#!/bin/sh
cd /autotrace
find inputs -type f -name '*.png' -exec ./test_lineart.sh {} \;
