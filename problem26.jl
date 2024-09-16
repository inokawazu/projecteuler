function reciprocal_cycle_pairs(n::T) where T
    num = one(n)
    dem = n

    seen = Tuple{T, T}[]

    while true
        if iszero(num)
            break
        elseif num < dem
            num *= 10
            continue
        elseif (num, dem) in seen
            push!(seen, (num, dem))
            break
        end

        push!(seen, (num, dem))

        _, num = divrem(num, dem)
    end

    return seen
end

function reciprocal_cycle_length(n)
    digit_pairs = reciprocal_cycle_pairs(n)
    firstpair_ind = findfirst(==(digit_pairs[end]), digit_pairs)
    if isnothing(firstpair_ind)
        zero(n)
    else
        length(digit_pairs) - firstpair_ind
    end
end

#  |05
# 2|10
#  |10
#  | 0

#  |03...
# 3|10
#  |09
#  | 1

#  |01
# 7|10
#  |07
#  | 30

function solution(limit)
    return argmax(reciprocal_cycle_length, 1:limit-1)
end

const INPUT = 1_000
println(solution(INPUT))
