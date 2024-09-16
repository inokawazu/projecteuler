function solution(input::T) where T
    nmax = (input - 1) ÷ 2
    oddsquares = ((2n+1)^2 for n in 1:nmax)

    4 * sum(enumerate(oddsquares)) do (n, osq)
        osq-3n
    end + 1
end

const INPUT = 1001
println(solution(INPUT))
