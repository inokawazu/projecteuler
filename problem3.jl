# https://projecteuler.net/problem=3

function isprime(n)
    for i in 2:isqrt(n)
        if mod(n, i) == 0
            return false
        end
    end
    return true
end

function solution(n)
    maxp = 1
    for i in 1:isqrt(n)
        if iszero(mod(n, i)) && isprime(i)
            maxp = max(i, maxp)
            n = n ÷ i
        end
    end
    return maxp
end

const INPUT = 600851475143
println(solution(INPUT))
