makeFCache(T::DataType) = Dict{Tuple{T, T}, T}()

"""
`m`: `m` units length of block
`n`: row width of `n` units
"""
function F(m::T, n::T, cache = makeFCache(T)) where T <: Integer
    if n <= 0
        return cache[(m, n)] = one(T)
    elseif haskey(cache, (m, n))
        return cache[(m, n)]
    end

    ways = F(m, n - 1, cache) # not placing
    if n >= m
        ways += F(m, n - m, cache)
    end

    cache[(m, n)] = ways
    return ways
end

function solution(n::T) where T
    cache = makeFCache(T)
    ms = T[2, 3, 4]
    out = sum(ms) do m
        F(m, n, cache) - 1
    end

    return out
end

println(solution(50))
