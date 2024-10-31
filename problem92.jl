function sum_sqrtdigigs(n::Integer)
    @assert n > 0
    output = zero(n)
    while !iszero(n)
        n, dig = divrem(n, 10)
        output += dig^2
    end
    return output
end

function find_end(n, ends = (1, 89))
    while !(n in ends)
        n = sum_sqrtdigigs(n)
    end
    return n
end

function solution(limit = 10_000_000)
    precomlim = 9^2 * ndigits(limit)
    reference = map(find_end, 1:precomlim)
    
    count(1:limit) do n
        reference[sum_sqrtdigigs(n)] == 89
    end
end

println(solution())
