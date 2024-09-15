function solution(n)
    return sum(digits(factorial(big(n))))
end

const INPUT = 100
println(solution(INPUT))
