include("common.jl")

function solution(target = 1_000_000)
    return sum(totient, 2:target)
end

println(solution())
