include("common.jl")

iscomposite(n) = !isprime(n) && n > 1
issquare(n::Integer) = n == isqrt(n)^2

function solution()
    nums = Iterators.countfrom(2)
    primes = Iterators.filter(isprime, nums)
    comps = Iterators.filter(n -> isodd(n) && iscomposite(n), nums)

    for comp in comps
        smaller_primes = Iterators.takewhile(<=(comp), primes)
        conjecture_true = any(smaller_primes) do prime
            issquare((comp - prime) ÷ 2)
        end
        if !conjecture_true
            return comp
        end
    end
end

println(solution())
