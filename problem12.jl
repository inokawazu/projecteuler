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

add1(n) = n + 1
countdivs(divs) = prod(Iterators.map(add1, values(divs)))

function ntriangle_ndivisors(n)
    even, odd = iseven(n) ? (n, n+1) : (n+1, n)
    even ÷= 2
    evenodddivs = mergewith(+, pfactors(even), pfactors(odd))
    return countdivs(evenodddivs)
end

function solution(target)
    trindivss = Iterators.map(n->(n, ntriangle_ndivisors(n)), Iterators.countfrom(2))
    belowtarget = Iterators.filter(nc->nc[2]>target, trindivss)
    ntarget = first(belowtarget)[1]
    return ntarget * (ntarget + 1) ÷ 2
end

const TARGET = 500
println(solution(TARGET))
