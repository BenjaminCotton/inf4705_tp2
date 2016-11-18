#!/usr/bin/env python3

# best, avg, worst : O(n*log(n))

from algorithms.algorithm import *
from random import random

def prob(p):
    return random() < p

class Vorace(TowerAlgorithm):
    name = "vorace"

    def make_tower(self, blocks):
        sorted_blocks = sorted(blocks, key=lambda b: (b.area(), b.w, b.h), reverse=True)
        top, tower, size = None, [], 0
        for b in sorted_blocks:
            if b.fits_on(top) and prob(0.9):
                top = b
                tower.append(b)
                size += b.height()
        return (size, tower)
