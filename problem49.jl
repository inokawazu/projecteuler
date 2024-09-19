include("common.jl")

function solution()
    nums = Iterators.countfrom()
    primes = Iterators.filter(isprime, nums)
    fourdigprimes = Iterators.dropwhile(n -> ndigits(n) < 4, primes)
    fourdigprimes = Iterators.takewhile(n -> ndigits(n) == 4, fourdigprimes)

    foundfirst = false

    for fdp in fourdigprimes
        for offset in 1:(9999-fdp)÷2
            sequence = (fdp, fdp + offset, fdp + 2offset)

            areperms() = allequal(Iterators.map(sort∘digits, sequence))
            if all(isprime, sequence) && areperms()
                if foundfirst
                    return reduce(concateprod, sequence)
                end
                foundfirst = true
            end
        end
    end
end

println(solution())
