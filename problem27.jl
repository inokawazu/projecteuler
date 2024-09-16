function isprime(n)
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

quadf(n, a, b) = @evalpoly(n, b, a, one(n))

function solution(alimit, blimit)
    as = -alimit+1:alimit-1
    bs = -blimit:blimit
    amax, bmax = argmax(Iterators.product(as, bs)) do (a, b)
        nums = Iterators.countfrom(zero(a))
        qnums = Iterators.map(n->quadf(n, a, b), nums)
        pqnums = Iterators.takewhile(isprime, qnums)
        count(_->true, pqnums)
    end

    return amax * bmax
end

const AINPUT = 1000
const BINPUT = 1000
println(solution(AINPUT, BINPUT))
