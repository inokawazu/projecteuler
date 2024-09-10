function ispythagoreantriple(a::Integer, b::Integer, c::Integer)
    return 0 < a < b < c && a^2 + b^2 == c^2
end

function solution(n = 1000)
    for a in 0:n
        for b in (a+1):n
            c = n - a - b
            if ispythagoreantriple(a, b, c)
                return a*b*c
            end
        end
    end
    return -1
end

println(solution())
