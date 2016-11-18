#!/bin/bash

OUT=$1

echo "# lscpu | grep -E '(cache)|(name)|(MHz)'; cat /proc/meminfo | grep 'Mem*'" > $OUT

(lscpu | grep -E '(cache)|(name)|(MHz)'; cat /proc/meminfo | grep 'Mem*') >> $OUT
