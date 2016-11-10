#!/bin/bash

SCRIPTS=./script
RES=./results
AMORT=1
DATA=$1

$SCRIPTS/save_hardware.sh $RES/hardware.txt
$SCRIPTS/time_all.py -r $RES -d $DATA -m $AMORT
