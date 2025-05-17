makeFCache(T::DataType) = Dict{Tuple{T, T}, T}()

"""
`m`: minimum length of `m` units
`n`: row width of `n` units
"""
function F(m::T, n::T, cache = makeFCache(T)) where T <: Integer
    if n <= 0
        return one(T)
    elseif haskey(cache, (m, n))
        return cache[(m, n)]
    end

    ways = F(m, n - 1, cache) # not placing

    for block_width in m:n
        next_n = max(n - (block_width + 1), 0)
        ways += F(m, next_n, cache)
    end

    cache[(m, n)] = ways
    return ways
end

function solution(m::T, goal) where T
    cache = makeFCache(T)
    for n in Iterators.countfrom(zero(T))
        if F(m, n, cache) > goal
            return n
        end
    end
end

println(solution(50, 1000000))
