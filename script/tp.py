#!/usr/bin/env python3

import argparse
from collections import OrderedDict

from context import algorithms
from algorithms.vorace import Vorace
from algorithms.progdyn import Progdyn
from algorithms.tabou import Tabou
from algorithms.timing import time_algo

algorithms = [
    Vorace(),
    Progdyn(),
    Tabou(),
]

algomap = OrderedDict((a.get_name(), a) for a in algorithms)

parser = argparse.ArgumentParser(
    description="Start and time choosing algorithms for the lab")
parser.add_argument("--algorithm", "-a", choices=algomap.keys(),
                    required=True)
parser.add_argument("--ex_path", "-e", type=argparse.FileType('r'),
                    required=True,
                    help="the file containing the blocs to place in the tower")
parser.add_argument("--print", "-p", action='store_true',
                    help="print the blocs used in the tower")
parser.add_argument("--time", "-t", action='store_true',
                    help="show the mean time of execution")
parser.add_argument("--amortize", "-m", type=int, default=1,
                    metavar="N",
                    help="amortize the timing overhead over N" \
                    " executions")

def main():
    args = parser.parse_args()

    algo = algomap[args.algorithm]
    with args.ex_path as f:
        nbBlocs = int(f.readline())
        items = []
        # For every dimensions, add the 3 possibles blocs in the items list.
        # item[0] = height
        # item[1] = width (smallest dimension between the 2 left)
        # item[2] = depth (biggest dimension of the 2 left)
        for x in range(nbBlocs) :
            dimensions = f.readline().split()
            dimensions = [int(i) for i in dimensions]
            items.append([dimensions[0], min(dimensions[1],dimensions[2]), max(dimensions[1],dimensions[2])])
            items.append([dimensions[1], min(dimensions[0],dimensions[2]), max(dimensions[0],dimensions[2])])
            items.append([dimensions[2], min(dimensions[0],dimensions[1]), max(dimensions[0],dimensions[1])])

    average, blocsUsed = time_algo(algo, items, args.amortize)

    if args.time:
        print("Mean time: {} seconds".format(average))

    if args.print:
        for bloc in blocsUsed :
            print(items[bloc])

if __name__ == "__main__":
    main()
