include("common.jl")

function nsqrdivs(nfactors)
    prod(2a+1 for a in nfactors)
end

function numberofsols(factors)
    (nsqrdivs(factors)+1)÷2
end

function findn(primes, pfactors)
    T = eltype(primes)
    prod((p ^ a for (p, a) in zip(primes, pfactors)), init = one(T))
end

function solution(target, nprimes, higherbound = typemax(target)÷100)
    primes = Iterators.filter(isprime, Iterators.countfrom(2one(target)))
    primes = Iterators.take(primes, nprimes)
    primes = collect(primes)

    factors = zero.(primes)
    minn = Ref(higherbound)

    reverse!(primes)
    function findminn(i = 1)
        if findn(primes, factors) >= minn[]
            return false
        elseif numberofsols(factors) > target
            minn[] = findn(primes, factors)
            return true
        elseif i > length(primes)
            return false
        end

        for jfact in Iterators.countfrom(zero(target))
            factors[i] = jfact
            findminn(i + 1)
            if findn(primes, factors) > minn[]
                break
            end
        end
        factors[i] = 0
        return true
    end

    findminn()
    return minn[]
end

println(solution(4 * 10^6, 12))
