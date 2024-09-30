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

            @assert bn >= 0
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
                    typemax(I)
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
end

println(solution())
