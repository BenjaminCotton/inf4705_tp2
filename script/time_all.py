#!/usr/bin/env python3

import argparse, os

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

parser = argparse.ArgumentParser(
    description="Gather data for the lab")
parser.add_argument("--data_dir", "-d", required=True,
                    help="the directory containing the datasets")
parser.add_argument("--results_dir", "-r", default="results",
                    help="the directory containing the results")
parser.add_argument("--amortize", "-m", type=int, default=1,
                    metavar="N",
                    help="amortize the timing overhead over N" \
                    " executions")

def main():
    args = parser.parse_args()

    if not (os.path.isdir(args.data_dir) and
            os.path.isdir(args.results_dir)):
        parser.print_usage()
        exit(1)
    
    sizes = [100, 500, 1000, 5000, 10000, 50000]#, 100000, 500000]
    set = range(0,10)

    for algorithm in algorithms:
        result_name = "{}.dat".format(algorithm.get_name())
        result_name = os.path.join(args.results_dir, result_name)
        result = open(result_name, 'w')
        print("Making {}".format(result_name))
        result.write("# Taille [0-9]\n")
        for size in sizes :
            result.write(str(size) + "\t")
            total = 0
            for series in set :
                data_name = "b{}_{}".format(size, series)
                data_name = os.path.join(args.data_dir, data_name)
                print("Reading {}".format(data_name))
                with open(data_name, 'r') as testset:
                    nbBlocs = int(testset.readline())
                    items = []
                    for x in range(nbBlocs):
                        dimensions = testset.readline().split()
                        dimensions = [int(i) for i in dimensions]
                        items.append(
                            [dimensions[0], min(dimensions[1], dimensions[2]), max(dimensions[1], dimensions[2])])
                        items.append(
                            [dimensions[1], min(dimensions[0], dimensions[2]), max(dimensions[0], dimensions[2])])
                        items.append(
                            [dimensions[2], min(dimensions[0], dimensions[1]), max(dimensions[0], dimensions[1])])
                if algorithm.get_name() == "vorace" :
                    timed, _ = time_algo(algorithm, items,
                                         args.amortize*10)
                else :
                    timed, _ = time_algo(algorithm, items,
                                        args.amortize)
                total += timed
            average = total / len(set)
            result.write("%.6f\t" % average)
            result.write('\n')
        result.close()

if __name__ == "__main__":
    main()
