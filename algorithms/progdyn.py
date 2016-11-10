#!/usr/bin/env python3

# min, moy = x^2
# max = x^3

from algorithms.algorithm import *
import operator

class Progdyn(ChoosingAlgorithm):
    name = "progdyn"

    def _choose(self, items):
        surfaces = {}
        for i in range(len(items)) :
            # Put the indexes and the surface of the blocs in a list
            surface = items[i][1]*items[i][2]
            if surfaces.get(surface) == None :
                surfaces[surface] = {}
            if surfaces[surface].get(items[i][1]) == None :
                surfaces[surface][items[i][1]] = [i,items[i][0]]
            elif surfaces[surface][items[i][1]][1] < items[i][0] :
                surfaces[surface][items[i][1]] = [i, items[i][0]]
        for key in surfaces :
            surfaces[key] = [value for (key, value) in sorted(surfaces[key].items(), reverse = True)]
        # Sort the list with the biggest surface in front
        sorted_surfaces = [item[0] for (key, value) in sorted(surfaces.items(), reverse = True) for item in value]
        # This list will contain the highest tower possible with every blocs on top, ordered by their height
        # In other words, 300 blocs = 300 towers
        # the towers are in this format :
        # tower[0] = height of the tower
        # tower[1] = width of the bloc on top
        # tower[2] = depth of the bloc on top
        # tower[3:] = indexes of the blocs in the tower with the bottom first
        towers = []
        # Start with the biggest surface
        firstIndex = sorted_surfaces.pop(0)
        firstBloc = items[firstIndex]
        towers.append([firstBloc[0],firstBloc[1],firstBloc[2],firstIndex])
        lastBloc = firstBloc
        # For all the blocs, starting with the biggest surfaces
        for blocIndex in sorted_surfaces :
            bloc = items[blocIndex]
            towerFound = False
            # Find the highest tower that the bloc can fit on
            for towerIndex in range (len(towers)) :
                tower = towers[towerIndex]
                # If the bloc fit on the top of the tower
                if bloc[1] < tower[1] and bloc[2] < tower[2] :
                    # Add the new tower to "towers" and place it at the right place in the list depending on its height
                    towerFound = True
                    towers.insert(towerIndex,[tower[0]+bloc[0], bloc[1], bloc[2]])
                    towers[towerIndex].extend(tower[3:])
                    towers[towerIndex].append(blocIndex)
                    presentIndex = towerIndex
                    while presentIndex != 0 and towers[presentIndex][0] > towers[presentIndex-1][0]:
                        towers[presentIndex], towers[presentIndex-1] = towers[presentIndex-1], towers[presentIndex]
                        presentIndex -= 1
                    break
            # If the bloc doesn't fit on any existing tower
            if not towerFound :
                # Start a new tower, add it to "towers" and place it at the right place in the list depending on its height
                towers.append([bloc[0], bloc[1], bloc[2], blocIndex])
                presentIndex = len(towers)-1
                while presentIndex != 0 and towers[presentIndex][0] > towers[presentIndex - 1][0]:
                    towers[presentIndex], towers[presentIndex - 1] = towers[presentIndex - 1], towers[
                        presentIndex]
                    presentIndex -= 1
        print("Height : ",towers[0][0])
        return towers[0][3:]



