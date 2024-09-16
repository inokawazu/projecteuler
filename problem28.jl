function solution(input::T) where T
    nmax = (input - 1) ÷ 2
    4 * sum(1:nmax) do n
        4*n^2 + n + 1
    end + 1
end

const INPUT = 1001
println(solution(INPUT))
