function solution(target::T = 1_000_000) where T
    ways = [one(T)]
    for n in Iterators.countfrom(one(T))
        nway = zero(T)

        k = 1
        while n - k * (3k - 1) ÷ 2 >= 0
            nk = n - k * (3k - 1) ÷ 2
            nway += (-1)^(k+1) * ways[nk+1]
            k += 1
        end

        k = 1
        while n - k * (3k + 1) ÷ 2 >= 0
            nk = (n - k * (3k + 1) ÷ 2)
            nway += (-1)^(k+1) * ways[nk+1]
            k += 1
        end

        if nway % target == 0
            return n
        end
        push!(ways, nway % target)
    end
end

println(solution())
