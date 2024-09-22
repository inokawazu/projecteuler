include("common.jl")

function solution(limit = 1_000_000)
    nums = Iterators.countfrom()
    primes = Iterators.filter(isprime, nums)
    belowlim = collect(Iterators.takewhile(<(limit), primes))
    
    maxcount = 0
    maxcountprime = 0
    for (ai, ap) in enumerate(belowlim)
        for bi in 1:ai
            bp = belowlim[bi]
            if maxcount * bp > ap
                break
            end

            prime = ap
            count = 0
            while prime > 0
                prime -= belowlim[bi]
                count += 1
                bi += 1
            end

            count *= iszero(prime)
            if count > maxcount
                maxcount = count
                maxcountprime = ap
            end
        end
    end
    return maxcountprime
end

println(solution())
