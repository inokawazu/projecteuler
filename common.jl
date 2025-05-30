function concateprod(a, b)
    a * 10^ndigits(b) + b
end

nthdigit(n, nth; base = 10) = n ÷ base^(nth - 1) % base

function idigits(n::Integer; base = 10)
    Iterators.map(nth -> nthdigit(n, nth, base = base), 1:ndigits(n, base = base))
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

rrpartitions(x, n) = (x[i:n:length(x)] for i in 1:n)

function continued_fraction_convergents(a::Function, T = Int)
    as = Iterators.map(a, Iterators.countfrom(zero(T)))
    return continued_fraction_convergents(as, T)
end

function continued_fraction_convergents(as, T = Int)
    Channel{Rational{T}}() do c
        pmm1 = one(T)
        pmm2 = zero(T)

        qmm1 = zero(T)
        qmm2 = one(T)

        pm = zero(T)
        qm = zero(T)
        for am in as
            pm = am * pmm1 + pmm2
            qm = am * qmm1 + qmm2

            put!(c, pm//qm)

            pmm2 = pmm1
            qmm2 = qmm1

            pmm1 = pm
            qmm1 = qm
        end
    end
end

function totient(n::T) where T <: Integer
    pro = one(T)
    maxi = isqrt(n)

    for p in Iterators.countfrom(2one(T))
        k = zero(T)

        while mod(n, p) == 0
            n ÷= p
            k += 1
        end

        if k > 0
            pro *= p^(k-1) * (p - 1)
        elseif isone(n)
            break
        elseif p == maxi
            pro *= (n - 1)
            n ÷= n
            break
        end
    end

    return pro
end

function combinations(elems, n)
    let elems = copy(elems), VT = Vector{eltype(elems)}
        Channel{VT}() do ch
            v = VT(undef, n)

            function f!(i=1, j=0)
                if i > n
                    put!(ch, copy(v))
                    return
                end

                for j_next in j+1:length(elems)
                    v[i] = elems[j_next]
                    f!(i + 1, j_next)
                end
            end
            f!()
        end
    end
end
