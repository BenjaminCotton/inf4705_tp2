import time

def time_algo(algo, items, amortization):
    """Time a choosing algorithm

    The cost of the time probes is amortized over the number of
    executions specified by the amortization parameter.

    The function returns both the average time of execution and the
    choosed items.

    """
    start = time.process_time()
    for _ in range(amortization):
        blocsUsed = algo.choose(items)
    stop = time.process_time()
    elapsed = stop - start
    average = elapsed / amortization
    return (average, blocsUsed)
