function d(n::Integer)
    sum(2:isqrt(n), init = one(n)) do i
        d, r = divrem(n, i)
        if iszero(r) && d == i
            i
        elseif iszero(r)
            i + d
        else
            zero(n)
        end
    end
end

function isamicable(n)
    dn = d(n)
    n > 1 && dn != n && n == d(dn)
end

function solution(LIMIT)
    return sum(Iterators.filter(isamicable, 1:LIMIT-1))
end

const INPUT = 10_000
println(solution(INPUT))
