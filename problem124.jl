function rad(n::Integer)
    out = one(n)
    for i in 2:isqrt(n)
        if mod(n, i) == 0
            out *= i
            while mod(n, i) == 0
                n ÷= i
            end
        end
    end

    return out * n
end

function solution(nmax::Integer, n)
    radpairs = map(x->(rad(x), x), 1:nmax)
    sort!(radpairs)[n][2]
end

println(solution(100_000, 10_000))
