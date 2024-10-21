include("common.jl")

function solution(target::T = 50_000_000) where T
    powers = (2, 3, 4)
    minpow = minimum(powers)
    nums = Iterators.countfrom(one(T))
    primes = Iterators.filter(isprime, nums)
    tprimes = collect(Iterators.takewhile(p->p^minpow <= target, primes))

    power_triples = [zero(T)]

    for power in sort(collect(powers))
        new_triples = Iterators.flatmap(power_triples) do pt
            pluspt = Iterators.map(p -> p^power + pt, tprimes)
            Iterators.takewhile(<=(target), pluspt)
        end
        power_triples = unique(new_triples)
    end

    return length(power_triples)
end

println(solution())
