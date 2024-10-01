include("common.jl")

function sqrt_cf_sequence(n::I) where I <: Integer
    return Channel{Tuple{I, I, I}}() do ch
        an::I = isqrt(n)
        bn::I = an
        cn::I = 1
        push!(ch, (an, bn, cn))

        if an^2 == n
            return
        end

        while true
            mn = n - bn^2

            @assert bn >= 0
            @assert mn % cn == 0
            dn = mn ÷ cn
            
            nums = Iterators.countfrom(zero(I))
            lowkns = Iterators.dropwhile(kn -> kn * dn <= bn, nums)
            highkns = Iterators.takewhile(kn -> (kn * dn - bn)^2 < n, lowkns)
            kn = argmin(highkns) do kn
                res = √n + bn - kn * dn
                if res > 0
                    res
                else
                    typemax(I)
                end
            end

            an, bn, cn = kn, -bn + kn * dn, dn
            push!(ch, (an, bn, cn))
        end
    end
end

function getx(D::I) where I
    if isqrt(D)^2 == D
        return one(D), D
    end

    as = Iterators.map(first, sqrt_cf_sequence(D))

    for convergent in continued_fraction_convergents(as, typeof(D))
        x, y = numerator(convergent), denominator(convergent)
        if x^2 - D*y^2 == 1
            return x, D
        end
    end

    return one(D), D
end

function solution(target::T = big"1000") where T
    Ds = one(T):target

    xs = Iterators.map(getx, Ds)

    return last(argmax(first, xs))

end

println(solution())
