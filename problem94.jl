function isareaintegral(a, b)
    # b * sqrt(4a^2 - b^2) / 4
    # b * sqrt(d) / 4
    # b * e / 4
    d = 4*a^2 - b^2
    e = isqrt(d)
    isqrt(d)^2 == d && mod(d*e, 4) == 0
end

isoperimeter(a, b) = 2a + b

function subsol(as, limit)
    sol = eltype(as)
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
    sol = 0
    for a in 2:limit
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

println(solution())
