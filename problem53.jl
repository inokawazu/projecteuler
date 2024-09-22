function solution(target=1_000_000, nmax=100)
    return count(binomial(n, r) > target for n in big(1):nmax for r in 1:n)
end

println(solution())
