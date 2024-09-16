include("common.jl")

function islefttrunc(n)
    while n > 0
        if !isprime(n)
            return false
        end
        e = ndigits(n) - 1
        n = rem(n, 10^e)
    end

    return true
end

function isrighttrunc(n)
    while n > 0
        if !isprime(n)
            return false
        end

        n = div(n, 10)
    end

    return true
end

isleftrighttrunc(n) = islefttrunc(n) && isrighttrunc(n)

function solution()
    # NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
    nums = Iterators.countfrom(8)
    leftrightps = Iterators.filter(isleftrighttrunc, nums)
    # Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
    bottomlrps = Iterators.take(leftrightps, 11)
    sum(bottomlrps)
end

println(solution())
