function divisible_bys(n::Integer)
    ( i for i in 2:n if mod(n, i) == 0 )
end

isproduct_sum(n, k) = isproduct_sum(n, n, k)

function isproduct_sum(n, m, k)

    if k == 0
        return n == 1 && m == 0
    elseif n == 1
        return m == k
    end

    @assert k > 0
    @assert n > 0
    @assert m >= 0

    res = false

    for d in divisible_bys(n)
        if d > m
            break
        end

        if isproduct_sum(n ÷ d, m - d, k - 1)
            res = true
            break
        end
    end

    return res
end

function solution(limit::T = 12000; lower=2one(T)) where T
    n = 2
    k = lower
    res_set = Set{T}()

    tasks = map(2:limit) do k
        Threads.@spawn let n = 2
            while !isproduct_sum(n, k)
                n += 1
            end
            n
        end
    end

    for task in tasks
        push!(res_set, fetch(task))
    end

    # for k in 2:limit
    #     # print(k, " ")
    #     n = 2
    #     while !isproduct_sum(n, k)
    #         n += 1
    #     end
    #     push!(res_set, n)
    # end
    # println()

    return sum(res_set)
end

println(solution(12000))
