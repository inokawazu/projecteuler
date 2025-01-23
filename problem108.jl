function solution(mincount = 1000)
    nums = Iterators.countfrom()
    for n in nums
        ncnt = 0
        for x in Iterators.countfrom(n + 1)
            for y in Iterators.countfrom(fld(n*x, x - n))
                if x * y  > n * (x + y)
                    break
                elseif x * y == n * (x + y)
                    ncnt += 1
                    break
                end
            end
            if x * x  > n * (x + x)
                break
            end
        end
        if ncnt > mincount
            return n
        end
    end

    return -1
end

solution()
