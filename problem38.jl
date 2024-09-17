include("common.jl")

function solution()
    limit = 9999
    largest = 0
    panlimit = 9

    # n > 1
    for n in 2:limit
        nums = Iterators.countfrom(1)

        inprods = Iterators.map(x->n*x, nums)

        accdigits = Iterators.accumulate(inprods, init = 0) do ndigs, inprod
            ndigs + ndigits(inprod)
        end

        limitedadigs = Iterators.takewhile(<=(panlimit), accdigits)

        cand = mapreduce(last, concateprod, zip(limitedadigs, inprods))

        if ispandigital(cand)
            largest = max(largest, cand)
        end
    end

    return largest
end

println(solution())
