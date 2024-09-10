function solution(n)
    return ( n * (n+1)÷2 )^2 - n * (n+1) * (2n + 1)÷6
end

const INPUT = 100
println(solution(INPUT))
