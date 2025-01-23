include("common.jl")

function count_sols(n)
    nsols = 1 

    for i in 2:isqrt(n)
        if mod(n, i) == 0
            ai = 0
            while mod(n, i) == 0
                ai += 1
                n ÷= i
            end
            nsols *= 2ai + 1
        end
    end

    return (nsols + 1) ÷ 2
end

function solution(mincount = 1000)
    for n in Iterators.countfrom(mincount)
        if count_sols(n) > mincount return n end
    end
    return -one(mincount)
end

println(solution())
