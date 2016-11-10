#!/usr/bin/env python3

# min = x
# moy, max = x^2

from algorithms.algorithm import *
from random import randrange

def findTower(items):
    # Tower made by the algorithm
    tower = []
    # Height of the tower
    towerSize = 0
    # All the items indexes
    possibleIndexes = list(range(len(items)))
    # Choose a random item in the list
    random_index = randrange(len(possibleIndexes))
    # Add the item to the tower, it will be our first bloc
    tower.append(possibleIndexes.pop(random_index))
    # Add the height of the bloc to the tower height
    towerSize += items[tower[0]][0]

    # While there is still items that we didn't try to put in the tower
    while len(possibleIndexes) > 0:
        # Choose a random item
        random_index = randrange(0, len(possibleIndexes))
        blocIndex = possibleIndexes.pop(random_index)
        bloc = items[blocIndex]
        previousItem = []
        towerIndex = 0
        # Try to find where the bloc can fit in the tower
        for itemIndex in tower:
            # If the dimensions of the bloc are bigger than the one on top
            topBloc = items[itemIndex]
            if bloc[1] > topBloc[1] and bloc[2] > topBloc[2]:
                # Insert the bloc at this position and add the height of the bloc to the tower height
                # Then, go to an other bloc in the possible blocs
                tower.insert(towerIndex, blocIndex)
                towerSize += bloc[0]
                break
            # Continue looking only if the dimensions of the bloc are smaller than the one on top
            elif bloc[1] < topBloc[1] and bloc[2] < topBloc[2] :
                towerIndex += 1
                previousItem = topBloc
            # If not, go to an other bloc
            else :
                break
    # Return the tower height and indexes of the the blocs used to make the tower
    return [towerSize,tower]


class Vorace(ChoosingAlgorithm):
    name = "vorace"

    def _choose(self, items):
        tower = findTower(items)
        print("Height : ",tower[0])
        return tower[1]
