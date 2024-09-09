function solution(numdigits)
    maxprod = 0

    maxnum = 10^numdigits-1
    minnum = 10^(numdigits-1)

    for i in minnum:maxnum
        for j in i:maxnum
            p = i*j
            pdigits = digits(p)
            if pdigits == reverse(pdigits)
                maxprod = max(maxprod, p)
            end
        end
    end
    return maxprod
end

const INPUT = 3
println(solution(INPUT))
