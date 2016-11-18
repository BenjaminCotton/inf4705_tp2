#!/usr/bin/env python3

import argparse
from collections import OrderedDict

from context import algorithms
from algorithms.algorithm import *
from algorithms.vorace import Vorace
from algorithms.progdyn import Progdyn
from algorithms.tabou import Tabou
from algorithms.timing import time_algo

algorithms = [
    (Vorace(), 10),
    (Progdyn(), None),
    (Tabou(), None),
]

algomap = OrderedDict((a.get_name(), (a, m)) for a, m in algorithms)

parser = argparse.ArgumentParser(
    description="Start and time choosing algorithms for the lab")
parser.add_argument("--algorithm", "-a", choices=algomap.keys(),
                    required=True)
parser.add_argument("--ex_path", "-e", type=argparse.FileType('r'),
                    required=True,
                    help="the file containing the blocks to place in the tower")
parser.add_argument("--print", "-p", action='store_true',
                    help="print the blocks used in the tower")
parser.add_argument("--height", "-H", action='store_true',
                    help="print the height of the tower")
parser.add_argument("--check", "-c", action='store_true',
                    help="check to verify that the tower is balanced")
parser.add_argument("--time", "-t", action='store_true',
                    help="show the mean time of execution")
parser.add_argument("--amortize", "-m", type=int, default=1,
                    metavar="N",
                    help="amortize the timing overhead over N" \
                    " executions")

def main():
    args = parser.parse_args()

    algo, def_amort = algomap[args.algorithm]
    if not args.amortize:
        args.amortize = def_amort
    with args.ex_path as f:
        n = int(f.readline())
        blocks = []
        for _ in range(n) :
            dims = map(int, f.readline().split())
            blocks.extend(Block.generate(*dims))

    average, (size, blocks) = time_algo(algo, (blocks,), args.amortize)

    if args.time:
        print("Mean time: {} seconds".format(average))

    if args.height:
        print("Height: {}".format(size))

    if args.print or args.check:
        top = None
        for b in blocks :
            if args.check and not b.fits_on(top):
                print("ERROR: Tower is not balanced")
            if args.print: print(b)
            top = b

if __name__ == "__main__":
    main()
