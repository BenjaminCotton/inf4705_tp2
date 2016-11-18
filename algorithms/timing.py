import time

def time_algo(algo, args, amortization):
    """Time an algorithm

    The cost of the time probes is amortized over the number of
    executions specified by the amortization parameter.

    The function returns both the average time of execution and the
    algorithm result.

    """
    start = time.process_time()
    for _ in range(amortization):
        res = algo.run(*args)
    stop = time.process_time()
    elapsed = stop - start
    average = elapsed / amortization
    return (average, res)
