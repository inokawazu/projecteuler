# In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation: 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

function solution(coins, targetvalue::T) where T
    ways = T[1]

    for value in 1:targetvalue
        push!(ways, zero(value))

        nways = length(ways)
        for coin in coins
            if coin < nways
                ways[end] += ways[end-coin]
            end
        end
    end

    @show ways
    return ways[end]
end

const COINS = [1, 2, 5, 10, 20, 50, 100, 200]
const TARGET = big(10)
println(solution(COINS, TARGET))
