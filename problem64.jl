function sqrt_cf_sequence(n::I) where I <: Integer
    return Channel{Tuple{I, I, I}}() do ch
        # an, cn/(√n - bn)
        an::I = isqrt(n)
        bn::I = an
        cn::I = 1
        push!(ch, (an, bn, cn))

        if an^2 == n
            return
        end

        while true
            # cn/(√n - bn) = cn * (√n + bn)/(n - bn^2)
            mn = n - bn^2

            # @show (an, bn, cn, mn)
            @assert bn >= 0
            # @assert mn >= 0
            @assert mn % cn == 0
            # cn * (√n + bn)/(n - bn^2) = cn * (√n + bn)/mn = (√n + bn)/dn
            dn = mn ÷ cn
            
            # kn + (√n + bn - kn * dn)/dn
            # kn + (√n - (-bn + kn * dn))/dn
            #
            # kn * dn > bn
            # n > (kn * dn - bn)^2
            nums = Iterators.countfrom(zero(I))
            lowkns = Iterators.dropwhile(kn -> kn * dn <= bn, nums)
            highkns = Iterators.takewhile(kn -> (kn * dn - bn)^2 < n, lowkns)
            kn = argmin(highkns) do kn
                res = √n + bn - kn * dn
                if res > 0
                    res
                else
                    Inf
                end
            end

            an, bn, cn = kn, -bn + kn * dn, dn
            push!(ch, (an, bn, cn))
        end
    end
end

function get_chain_length(n::I) where I
    cache = Set{Tuple{I, I, I}}()
    len = 0
    for resn in Iterators.drop(sqrt_cf_sequence(n), 1)
        if resn in cache
            return len
        else
            len += 1
            push!(cache, resn)
        end
    end
end

function solution(target = 10_000)
    nums = Iterators.countfrom(zero(target))
    bound_nums = Iterators.takewhile(<=(target), nums)
    nonsqrs = Iterators.filter(n->isqrt(n)^2 != n, bound_nums)
    return count(isodd∘get_chain_length, nonsqrs)
    # collect(Iterators.take(sqrt_cf_sequence(23), 10))
    # collect(Iterators.take(sqrt_cf_sequence(23), 10))
    
end

println(solution())


# √n
# k + √n - k
# k + 1/(1/(√n - k))
# k + 1/((√n + k)/(n - k^2))
# k + 1/((√n + k)/(n - k^2))
#
# (√n + k)/g = m + 1/(...)
# (√n + k)/g
# √n/g + k/g = m + 1/(...)
#
# (√n + k - i)/g
# ℤ ∋ i < k + √n
# ℤ ∋ ( i - k )^2 < n
#
# √n + k - i


# k/g + q/g = m
# k/g - q/g = m
