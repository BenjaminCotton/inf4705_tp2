#!/usr/bin/env python3

# space O(n)
# time O(n)

from algorithms.algorithm import *
from heapq import *
from random import sample, randrange

class Tabou(TowerAlgorithm):
    name = "tabou"

    def make_tower(self, blocks):
        tower, size = [], 0
        free = set(blocks)
        taboo = [] #heap (time, b)
        time, last_change = 0, 0
        while last_change + 100 > time:
            time += 1
            # Restore blocks from the taboo list
            while taboo and taboo[0][0] < time:
                _, b = heappop(taboo)
                free.add(b)
            # Choose a free block
            if not free:
                break
            chosen = sample(free, 1)[0]
            free.remove(chosen)
            # Try to put the chosen block in the tower
            replaced, replaced_size = [], 0
            rf, rl = -1, len(tower)
            for i, b in reversed(list(enumerate(tower))):
                if b.fits_on(chosen):
                    rl = i
                    continue
                if chosen.fits_on(b):
                    rf = i
                    break
                replaced.append(b)
                replaced_size += b.h
            if replaced_size > chosen.h:
                heappush(taboo, (time+randrange(7, 10), chosen))
                continue
            # Replace
            last_change = time
            tower[rf+1:rl] = [chosen]
            size -= replaced_size
            size += chosen.h
            for b in replaced:
                heappush(taboo, (time+randrange(7, 10), b))
        return size, tower
