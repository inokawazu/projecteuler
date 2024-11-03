function isareaintegral(a, b)
    d = 4*a^2 - b^2
    e = isqrt(d)
    isqrt(d)^2 == d && mod(d*e, 4) == 0
end

isoperimeter(a, b) = 2a + b

function subsol(as, limit)
    sol = zero(eltype(as))
    for a in as
        bm = a - 1
        bp = a + 1

        if isoperimeter(a, bm) > limit
            break
        elseif isareaintegral(a, bm)
            sol += isoperimeter(a, bm)
        end

        if isoperimeter(a, bp) <= limit && isareaintegral(a, bp)
            sol += isoperimeter(a, bp)
        end
    end
    return sol
end

function solution(limit=1_000_000_000)
    nths = Threads.nthreads()
    tsks = map(0:nths-1) do n
        Threads.@spawn subsol(2+n:nths:limit, limit)
    end

    return sum(fetch, tsks)
end

println(solution())
