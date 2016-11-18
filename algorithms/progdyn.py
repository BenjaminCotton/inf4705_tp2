#!/usr/bin/env python3

# min, moy = x^2
# max = x^3

from algorithms.algorithm import *

from collections import defaultdict

class Progdyn(TowerAlgorithm):
    name = "progdyn"

    def make_tower(self, blocks):
        areas = defaultdict(dict)
        # Remove doubles and suboptimal blocks of same base dimensions
        for i, b in enumerate(blocks) :
            area = b.area()
            if areas[area].get(b.w) == None :
                areas[area][b.w] = (i, b.h)
            elif areas[area][b.w][1] < b.h :
                areas[area][b.w] = (i, b.h)
        for a in areas :
            # replace the width dict with a list of values (tuple (i, b.h) )
            # ordered by descending width
            areas[a] = [tup for (_, tup) in sorted(areas[a].items(), reverse=True)]
        # Sort the list with the largest area in front
        sorted_areas = [item[0] for (_, tup_list) in sorted(areas.items(), reverse=True) for item in tup_list]
        # This list will contain the highest tower possible with every blocks on top, ordered by their height
        # In other words, 300 blocks = 300 towers
        # the towers are in this format :
        # tower[0] = height of the tower
        # tower[1] = width of the block on top
        # tower[2] = depth of the block on top
        # tower[3:] = indexes of the blocks in the tower with the bottom first
        towers = []
        # Start with the largest area
        firstIndex = sorted_areas.pop(0)
        firstBlock = blocks[firstIndex]
        towers.append([firstBlock.h,firstBlock.w,firstBlock.d,firstIndex])
        lastBlock = firstBlock
        # For every block, starting with the largest area
        for blockIndex in sorted_areas :
            block = blocks[blockIndex]
            towerFound = False
            # Find the highest tower that the block can fit on
            for towerIndex in range (len(towers)) :
                tower = towers[towerIndex]
                # If the block fit on the top of the tower
                if block.w < tower[1] and block.d < tower[2] :
                    # Add the new tower to "towers" and place it at the right place in the list depending on its height
                    towerFound = True
                    towers.insert(towerIndex,[tower[0]+block.h, block.w, block.d])
                    towers[towerIndex].extend(tower[3:])
                    towers[towerIndex].append(blockIndex)
                    presentIndex = towerIndex
                    while presentIndex != 0 and towers[presentIndex][0] > towers[presentIndex-1][0]:
                        towers[presentIndex], towers[presentIndex-1] = towers[presentIndex-1], towers[presentIndex]
                        presentIndex -= 1
                    break
            # If the block doesn't fit on any existing tower
            if not towerFound :
                # Start a new tower, add it to "towers" and place it at the right place in the list depending on its height
                towers.append([block.h, block.w, block.d, blockIndex])
                presentIndex = len(towers)-1
                while presentIndex != 0 and towers[presentIndex][0] > towers[presentIndex - 1][0]:
                    towers[presentIndex], towers[presentIndex - 1] = towers[presentIndex - 1], towers[
                        presentIndex]
                    presentIndex -= 1
        return towers[0][0], [blocks[i] for i in towers[0][3:]]



