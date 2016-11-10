import abc
from bisect import *

class ChoosingAlgorithm(metaclass=abc.ABCMeta):
    name = ""

    def __init__(self, name=""):
        if name:
            self.name = name

    def choose(self, items):
        return self._choose(items)

    @abc.abstractmethod
    def _choose(self, items):
        pass

    def get_name(self):
        return self.name