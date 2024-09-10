function isprime(n)
    n = abs(n)
    if n < 2
        return false
    end

    for i in 2:isqrt(n)
        if mod(n, i) == 0
            return false
        end
    end
    return true
end

function solution(limit)
    nats = Iterators.countfrom(1)
    primes = Iterators.filter(isprime, nats)
    limitprimes = Iterators.takewhile(<(limit), primes)
    return sum(limitprimes)
end

LIMIT = 2_000_000
println(solution(LIMIT))
