import abc
from bisect import *

class TowerAlgorithm(metaclass=abc.ABCMeta):
    name = ""

    def __init__(self, name=""):
        if name:
            self.name = name

    def run(self, *args):
        return self.make_tower(*args)

    @abc.abstractmethod
    def make_tower(self, blocks):
        pass

    def get_name(self):
        return self.name

class Block:
    def __init__(self, h, w, d):
        self.h = h
        self.w = w
        self.d = d
    def area(self):
        return self.w * self.d
    def fits_on(self, other):
        return not other or self.w < other.w and self.d < other.d
    def height(self):
        return self.h
    def __str__(self):
        return " ".join(str(i) for i in (self.h, self.w, self.d))
    def __repr__(self):
        return "Block({}, {}, {})".format(self.h, self.w, self.d)
    def __lt__(self, other):
        return (self.w, self.d, self.h) < (other.w, other.d, other.h)
    @staticmethod
    def generate(a, b, c):
        s = sorted([a,b,c])
        for i, x in enumerate(s):
            wo_x = s[:i]+s[(i+1):]
            yield Block(*([x] + wo_x))
