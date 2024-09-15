function solution(n, i)
    nums = collect(0:n-1)
    output = empty(nums)

    for factn in (n-1):-1:0
        j, i = fldmod1(i, factorial(factn))
        push!(output, popat!(nums, j))
    end

    join(output)
end

const INPUT = 1_000_000
const FACTORIALN = 10
println(solution(FACTORIALN, INPUT))
