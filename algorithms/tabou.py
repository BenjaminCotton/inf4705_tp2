#!/usr/bin/env python3

# min = x
# moy = x^2
# max = x^3

from algorithms.algorithm import *
from random import randrange

class Tabou(ChoosingAlgorithm):
    name = "tabou"

    def _choose(self, items):
        # Make a list of all the items' indexes
        possibleIndexes = list(range(len(items)))
        # This list will contain the indexes of the blocs used in the returned tower
        tower = []
        # This is the height of the returned tower
        towerHeight = 0
        # This is a list of the tabou blocs and their time left to be tabou (tabou for 7 to 10 iterations)
        # tabou[x][0] = time left to be tabou in terms of iterations
        # tabou[x][1] = index of the tabou bloc
        tabou = []
        # This will indicate the time when the current possible blocs can't fit in the tower. Then, only look at the old tabou ones
        currentBlocsDontFit = False
        iteration = 0
        # Only quit if its been 100 iterations where the tower hasn't change
        while iteration < 100 :
            j = 0
            # This list contains the indexes of the blocs that were tabou, but are not since this iteration
            tabouIndexes = []
            while j < len(tabou):
                tabou[j][0] -= 1
                if tabou[j][0] == 0:
                    tabouIndexes.append(tabou.pop(j)[1])
                else:
                    j += 1
            # Add the indexes of these blocs to the possibles blocs to use
            possibleIndexes.extend(tabouIndexes)
            # If no blocs from before could fit in the tower, only look at the old tabou blocs instead of all the blocs again
            iterationIndexes =[]
            if currentBlocsDontFit :
                iterationIndexes = tabouIndexes
            else :
                iterationIndexes = possibleIndexes
            # Start the iteration by setting the iteration highest tower as the current returned tower
            bestTowerHeight = towerHeight
            bestTower = tower
            # These will be the tabou created by the highest tower of the iteration
            iterationTabou = []
            bestIndex = -1
            # For every bloc we have to compare, which one make the greatest tower?
            for index in iterationIndexes :
                # start with the current tower and see what happend if we place the bloc in it
                tempTower = tower.copy()
                tempTowerHeight = towerHeight + items[index][0]
                # if the height of the bloc added to the current tower is lower than the highest tower
                # of the iteration, there is no need to continue looking at this bloc, because we know
                # for sure that adding it won't be usefull
                if tempTowerHeight < bestTowerHeight :
                    continue
                # Add the bloc at the top of the tower
                tempTower.append(index)
                presentIndex = len(tempTower)-1
                heightOff = 0
                tempTabou = []
                # While the bloc is not at the bottom of the tower, try to find where another bloc is bigger in dimensions than this one
                while presentIndex != 0:
                    presentBloc = items[tempTower[presentIndex]]
                    comparedBloc = items[tempTower[presentIndex-1]]
                    if presentBloc[1] >= comparedBloc[1] or presentBloc[2] >= comparedBloc[2] :
                            # If the comparedBloc bloc has a dimension bigger than this one, it means that it can't
                            # fit on top of this bloc, so take it out of the tower and put it in the tabou list for a
                            # time between 7 and 10 iterations
                            # (8 and 11 here, because it is first decremented before the first iteration)
                            if presentBloc[1] <= comparedBloc[1] or presentBloc[2] <= comparedBloc[2]:
                                tempTowerHeight -= comparedBloc[0]
                                heightOff += comparedBloc[0]
                                # If placing the bloc in the tower takes off more height than it give,
                                # take the bloc out of the possible blocs to put in the tower
                                if heightOff > presentBloc[0] :
                                    tempTowerHeight = 0
                                    possibleIndexes.remove(index)
                                # No need to continue if the tower is already to small to be the highest
                                if tempTowerHeight < bestTowerHeight:
                                    break
                                tempTabou.append([randrange(8,11),tempTower.pop(presentIndex-1)])
                            # If the bloc undex has a dimension smaller than this one, switch the 2 blocs' position in the tower
                            else :
                                tempTower[presentIndex], tempTower[presentIndex - 1] = tempTower[presentIndex - 1], \
                                                                                       tempTower[presentIndex]
                    else :
                        break
                    presentIndex -= 1
                # If the tower made with this bloc is higher than the highest one in this iteration
                if bestTowerHeight < tempTowerHeight :
                    # set the highest iteration tower as this one
                    bestTowerHeight = tempTowerHeight
                    bestTower = tempTower
                    iterationTabou = tempTabou
                    bestIndex = index
            # If a tower was bigger than the one we had before the iteration
            if bestIndex != -1 :
                # Set the returned tower as this one
                possibleIndexes.remove(bestIndex)
                tower = bestTower
                towerHeight = bestTowerHeight
                tabou.extend(iterationTabou)
            # If no tower was better than the one at the beggining, it means that we have 1 iteration where the tower hasn't change
            else :
                # Stop looking at these blocs, we already know they don't fit in the tower
                currentBlocsDontFit = True
                iteration += 1
        print("Height : ",towerHeight)
        return tower