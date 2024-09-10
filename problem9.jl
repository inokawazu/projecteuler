function ispythagoreantriple(a::Integer, b::Integer, c::Integer)
    return 0 < a < b < c && a^2 + b^2 == c^2
end

function solution(n = 1000)
    for a in 0:n
        for b in (a+1):n
            c = isqrt(a^2 + b^2)
            if  a + b + c == n && ispythagoreantriple(a, b, c)
                return a*b*c
            end
        end
    end
end

println(solution())
