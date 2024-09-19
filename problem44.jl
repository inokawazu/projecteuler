pentagonal_number(n::Integer) = n * (3n - 1) ÷ 2

# const PEN_CACHE = Set{Int}(pentagonal_number(n) for n in 1:1_000_000)
# const PEN_CACHE = falses(pentagonal_number(1_000_000))
# for n in 1:1_000_000
#     PEN_CACHE[pentagonal_number(n)] = true
# end

# pentagonal_number(n) for n in 1:1_000_000


# const NOPEN_CACHE = Set{Int}()
function ispentagonal(n::Integer)
    # return PEN_CACHE[n]
    # return n in PEN_CACHE
    # if n in PEN_CACHE
    #     return true
    # else
    #     return false
    # end

    nums = Iterators.countfrom(one(n))
    pents = Iterators.map(pentagonal_number, nums)

    return any(==(n), Iterators.takewhile(<=(n), pents))
    # res = any(==(n), Iterators.takewhile(<=(n), pents))

#     if res
#         push!(PEN_CACHE, n)
#     else
#         push!(NOPEN_CACHE, n)
#     end

#     return res
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

println(@time solution())
println(@time solution())
