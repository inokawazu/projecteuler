# In the United Kingdom the currency is made up of pound (£) and pence (p). There are eight coins in general circulation: 1p, 2p, 5p, 10p, 20p, 50p, £1 (100p), and £2 (200p).

function coinways(usuable_coins, current, target::T, smallestcoin = first(usuable_coins)) where T
    if current == target
        return one(T)
    end

    return sum(usuable_coins) do coin
        if coin >= smallestcoin && current + coin <= target
            coinways(usuable_coins, current + coin, target, coin)
        else
            zero(T)
        end
    end
end

function solution(coins, target::T) where T
    coinways(coins, zero(0), target)
end

const COINS = [1, 2, 5, 10, 20, 50, 100, 200]
const TARGET = 200
println(@time solution(COINS, TARGET))
println(@time solution(COINS, TARGET))
