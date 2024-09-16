function solution(maxdig=9)
    multiplicands = Set{Tuple{Int, Int, Int}}()

    for nm in Iterators.countfrom(1)
        maxdig-1-ndigits(nm) < 0 && break
        digitlim = 10^(maxdig-1-ndigits(nm)) - 1

        for n in 1:min(digitlim, isqrt(nm))
            iszero(mod(nm, n)) || continue
            m = nm ÷ n
            
            ndigits(m) + ndigits(n) + ndigits(nm) > maxdig && continue

            alldigs = [digits(n); digits(m); digits(nm)]
            if allunique(alldigs) && issetequal(alldigs, 1:maxdig)
                push!(multiplicands, (min(n, m), max(n, m), nm))
            end
        end
    end

    sum(last, unique(last, multiplicands))
end

println(solution())
