function pfactors(n::T) where T <: Integer
    divs = Dict{T, T}()
    maxi = isqrt(n)

    for i in Iterators.countfrom(2one(T))
        while mod(n, i) == 0
            n ÷= i
            divs[i] = get(divs, i, zero(T)) + 1
        end

        if isone(n)
            break
        elseif i == maxi
            divs[n] = get(divs, n, zero(T)) + 1
            n ÷= n
            break
        end
    end
    return divs
end

function solution(n)
    factormax(x, y) = mergewith(max, x, y)
    solfactors = mapreduce(pfactors, factormax, 2:n)
    prod(solfactors) do (base, expo)
        base^expo
    end
end

const INPUT = 20
println(solution(INPUT))
