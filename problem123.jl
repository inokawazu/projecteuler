# (p - 1)^n + (p + 1)^n
# sum_{k=0}^n (n choose k) p^(n-k) ((-1)^n + (+1)^n)
# 2 sum_{m=0}^(n÷2) (n choose k) p^(n-2m)
# (2 if n even else 2np) mod p^2

include("common.jl")

function solution(target)

    nums = Iterators.countfrom(2)
    primes = Iterators.filter(isprime, nums)
    for (n, pn) in enumerate(primes)
        r = iseven(n) ? 2*one(pn) : 2*n*pn
        if r > target
            return n
        end
    end
end

println(solution(10^10))
