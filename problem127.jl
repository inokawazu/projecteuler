include("common.jl")

function rad(x)
    maxi = isqrt(x)
    outprod = one(maxi)

    for i in 2:maxi
        hasdiv = false
        while x % i == 0
            hasdiv = true
            x ÷= i
        end

        if hasdiv
            outprod *= i
        end
    end

    return outprod * x
end

function isabc(a, b, c, radc)
    0 < a < b < c && a + b == c && 1 == gcd(a, b) && rad(a) * rad(b) * radc < c
end

function coprimepairs(limit::T) where T
    left = [(2one(T), one(T))]
    out = empty(left)
    while !isempty(left)
        (b, a) = popfirst!(left)
        push!(out, (b, a))
        if a + b < limit
            push!(left, (a + b, a))
            push!(left, (a + b, b))
        end
    end
    return out
end

function csum(cgroup)
    T = eltype(cgroup)
    sum(cgroup, init = zero(T)) do c
        radc = rad(c)
        sum(1:(cld(c, 2) + 1), init = zero(T)) do a
            b = c - a
            c * isabc(a, b, c, radc)
        end
    end
end

function solution(cmax::Integer)
    primecs = filter(!isprime, 1:cmax)
    cgroups = rrpartitions(primecs, Threads.nthreads())
    ctsks = map(cgroups) do cgroup
        Threads.@spawn csum(cgroup)
    end
    sum(fetch, ctsks)
end

# 120_000 => 18407904
println(solution(120_000))
