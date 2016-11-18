#!/bin/bash

DATA=$1
OUT=$2/limitproof.dat

cat $DATA/* | tr ' ' '\n' | sort -n | uniq -c >>$OUT
