function isprime(n::Integer)
    n = abs(n)
    if n < 2
        return false
    end

    return !any(2:isqrt(n)) do i
        iszero(mod(n, i))
    end
end

function solution(n)
    nats = Iterators.countfrom()
    primes = Iterators.filter(isprime, nats)
    primesnm1 = Iterators.drop(primes, n - 1)
    return first(primesnm1)
end

const INPUT = 10_001
println(solution(INPUT))
