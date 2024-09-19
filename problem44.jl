pentagonal_number(n::Integer) = n * (3n - 1) ÷ 2

function ispentagonal(n::Integer)
    nums = Iterators.countfrom(one(n))
    pents = Iterators.map(pentagonal_number, nums)

    return any(==(n), Iterators.takewhile(<=(n), pents))
end

function solution()
    for rightn in Iterators.countfrom(2)
        rpen = pentagonal_number(rightn)
        for leftn in 1:rightn
            lpen = pentagonal_number(leftn)
            if ispentagonal(rpen - lpen) && ispentagonal(rpen + lpen)
                return rpen - lpen 
            end
        end
    end
end

println(solution())
