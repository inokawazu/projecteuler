function solution(target=3//7, limit = 1_000_000)
    left = 0
    for den in 1:limit
        for num in fld(den*numerator(left), denominator(left)):den-1
            frac = num//den
            if frac >= target
                break
            elseif abs(frac - target) < abs(left - target)
                left = frac
            end
        end
    end

    return numerator(left)
end

println(solution())
