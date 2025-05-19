
makeFCache(T::DataType) = Dict{T, T}()

"""
`m`: `m` units length of block
`n`: row width of `n` units
"""
function F(n::T, cache = makeFCache(T)) where T <: Integer
    if n <= 0
        return cache[n] = one(T)
    elseif haskey(cache, n)
        return cache[n]
    end

    ways = F(n - 1, cache) # not placing

    for m in (2, 3, 4)
        if n >= m
            ways += F(n - m, cache)
        end
    end

    cache[n] = ways
    return ways
end

function solution(n::T) where T
    return F(n)
end

println(solution(50))
