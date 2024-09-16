function incorrect_cancels(n, m)
    ntens, nones = divrem(n, 10)
    mtens, mones = divrem(m, 10)

    if ntens == mtens
        return (nones, mones)
    elseif nones == mones
        return (ntens, mtens)
    elseif nones == mtens
        return (ntens, mones)
    elseif ntens == mones
        return (nones, mtens)
    else
        return (n, m)
    end
end

function solution()
    prodfrac = 1//1

    for n in 10:99
        for m in n+1:99
            mod(n, 10) == 0 && mod(m, 10) == 0 && continue

            cfrac = n//m
            cnum = numerator(cfrac)
            cnum == n && continue

            inum, iden = incorrect_cancels(n, m)
            inum == n && continue

            if cfrac == inum//iden
                prodfrac *= cfrac
            end
        end
    end
    
    return denominator(prodfrac)
end

println(solution())
