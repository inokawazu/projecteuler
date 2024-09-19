triangle(n) = n * (n+1)÷2
pentagonal(n) = n * (3n-1)÷2
hexagonal(n) = n * (2n-1)

function solution(target::T = 3) where T
    ns = T[1,1,1]
    matching = T[]

    while length(matching) < target
        nums = (triangle(ns[1]), pentagonal(ns[2]), hexagonal(ns[3]))
        if allequal(nums)
            push!(matching, nums[1])
            ns[1] += 1
            continue
        end

        _, i = findmin(nums)
        ns[i] += 1
    end

    return last(matching)
end

println(solution())
