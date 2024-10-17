function solution(target = 100)
    target_digits = 100

    sum(1:target) do n
        if isqrt(n)^2 == n
            zero(n)
        else
            setprecision(103, base = 10) do
                sqrtn = sqrt(float(big(n)))
                sqrtn *= big(10)^target_digits
                sqrtndigs = digits(floor(BigInt, sqrtn))
                sum(Iterators.take(Iterators.reverse(sqrtndigs), target_digits))
            end
        end
    end
end

println(solution())
