function sqrt2cf_convergents(T = Int)
    Channel{Rational{T}}() do c
        a(m) = m == 0 ? one(T) : 2one(T)
        pmm1 = one(T)
        pmm2 = zero(T)

        qmm1 = zero(T)
        qmm2 = one(T)

        pm = zero(T)
        qm = zero(T)
        for m in Iterators.countfrom(zero(T))
            pm = a(m) * pmm1 + pmm2
            qm = a(m) * qmm1 + qmm2

            put!(c, pm//qm)

            pmm2 = pmm1
            qmm2 = qmm1

            pmm1 = pm
            qmm1 = qm
        end
    end
end

function solution(limit::T = big(1_000)) where T
    sqrt2_fracs = sqrt2cf_convergents(T)
    sqrt2_fracs = Iterators.drop(sqrt2_fracs, 1)
    sqrt2_fracs = Iterators.take(sqrt2_fracs, limit)
    return count(sqrt2_fracs) do f
        ndigits(numerator(f)) > ndigits(denominator(f))
    end
end

println(solution())
