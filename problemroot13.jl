solution(x, ndigs) = setprecision((ndigs * 11) ÷ 10, base = 10) do
    f = sqrt(big(x)) * big(10) ^ 1000
    sum(digits(floor(BigInt, f))[begin:end-(x >= 1)])
end

println(solution(13, 1000))
