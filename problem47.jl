function ndistinctpfactors(n::T) where T <: Integer
    nfactors = 0

    for i in 2:isqrt(n)
        addedfactor = false
        while iszero(n % i)
            if !addedfactor
                nfactors += 1
            end

            n ÷= i
            addedfactor = true
        end
    end

    if !isone(n)
        nfactors += 1
    end

    return nfactors
end

function solution(targetlen = 4, nfactors = 4)
    nconsec = 0
    for num in Iterators.countfrom(1)
        if ndistinctpfactors(num) == nfactors
            nconsec += 1
        else
            nconsec = 0
        end
        if nconsec == targetlen
            return num - targetlen + 1
        end
    end
end

println(solution())
