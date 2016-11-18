#!/usr/bin/env python3

import argparse, os

from context import algorithms
from algorithms.algorithm import Block
from algorithms.vorace import Vorace
from algorithms.progdyn import Progdyn
from algorithms.tabou import Tabou
from algorithms.timing import time_algo

algorithms = [
    (Vorace(), 10),
    (Progdyn(), 1),
    (Tabou(), 1),
]

parser = argparse.ArgumentParser(
    description="Gather data for the lab")
parser.add_argument("--data_dir", "-d", required=True,
                    help="the directory containing the datasets")
parser.add_argument("--results_dir", "-r", default="../results/",
                    help="the directory containing the results")

def main():
    args = parser.parse_args()

    if not (os.path.isdir(args.data_dir)):
        parser.print_usage()
        exit(1)
    
    sizes = [100, 500, 1000, 5000, 10000, 50000, 100000, 500000]
    set = range(0,10)

    for algorithm, amort in algorithms:
        result_name = "{}.dat".format(algorithm.get_name())
        result_name = os.path.join(args.results_dir, result_name)
        result = open(result_name, 'w')
        print("Making {}".format(result_name))
        result.write("# Taille [0-9]\n")
        for size in sizes :
            result.write(str(size) + "\t")
            total = 0
            for series in set:
                data_name = "b{}_{}".format(size, series)
                data_name = os.path.join(args.data_dir, data_name)
                print("Reading {}".format(data_name))
                with open(data_name, 'r') as testset:
                    n = int(testset.readline())
                    blocks = []
                    for _ in range(n) :
                        dims = map(int, testset.readline().split())
                        blocks.extend(Block.generate(*dims))
                timed, _ = time_algo(algorithm, (blocks,), amort)
                total += timed
            average = total / len(set)
            result.write("%.6f\t" % average)
            result.write('\n')
        result.close()

if __name__ == "__main__":
    main()
