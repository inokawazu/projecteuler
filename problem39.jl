function solution(limit=1000)
    maxsolcount = 0
    maxp = 0

    for p in 1:limit 
        abs = ((a, b) for a in 1:p-1 for b in a:p)

        psolcount = count(abs) do (a, b)
            c = p - a - b
            a^2 + b^2 == c^2
        end

        if psolcount > maxsolcount
            maxsolcount = psolcount
            maxp = p
        end
    end
    return maxp
end

println(solution())
