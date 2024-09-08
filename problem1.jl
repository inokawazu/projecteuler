

is35div(x) = iszero(mod(x, 3)) || iszero(mod(x, 5))

function solution()
    limit = 1000
    nats = Iterators.countfrom()
    divnums = Iterators.filter(is35div, nats)
    belowlimit = Iterators.takewhile(<(limit), divnums)
    return sum(belowlimit)
end

println(solution())
