function solution(n)
    return sum(digits(big(2)^n))
end

const INPUT = 1_000
println(solution(INPUT))
