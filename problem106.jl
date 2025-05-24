include("common.jl")

function solution(n::Int)
    total = zero(n)
    elements = 1:n
    for k in 2:div(n, 2)
        for combo in combinations(elements, 2k)
            for b in combinations(combo, k)
                c = setdiff(combo, b)
                b_sorted = sort(b)
                c_sorted = sort(c)
                if b_sorted[1] < c_sorted[1]
                    if any(bi >= ci for (bi, ci) in zip(b_sorted, c_sorted))
                        total += 1
                    end
                end
            end
        end
    end
    return total
end

@show(solution(12))
