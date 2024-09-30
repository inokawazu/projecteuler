function concateprod(a, b)
    a * 10^ndigits(b) + b
end

function ispandigital(n, b=9)
    ds = digits(n)
    allunique(ds) && issetequal(ds, 1:b)
end

function isprime(n)
    n = abs(n)
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

function digs2num(digs::AbstractVector{T}) where T
    mapreduce(+, digs, zero(T):length(digs)-1) do d, e
        d * 10^e
    end
end

function continued_fraction_convergents(a::Function, T = Int)
    Channel{Rational{T}}() do c
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
