#!/bin/bash
 
#
# make some simple test folders with files inside
#


for x in $(seq 1 10) ; do mkdir proj${RANDOM} ; done

for x in proj* ; do for y in $(seq 1 10) ; do head --bytes 10000 /dev/urandom | base64 > ${x}/samp${RANDOM} ; done ; done
