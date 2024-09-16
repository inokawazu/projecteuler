function pdivisors(n::T) where T <: Integer
    divs = Dict{T, T}()
    for i in 2:isqrt(n)
        while iszero(n % i)
            n ÷= i
            divs[i] = get(divs, i, zero(T)) + 1
        end
    end

    if !isone(n)
        divs[n] = get(divs, n, zero(T)) + 1
        n ÷= n
    end

    return divs
end

muldivs(d1, d2) = mergewith(+, d1, d2)

function divpow(a, b)
    return mapreduce(pdivisors, muldivs, 
                     Iterators.repeated(a, b), 
                     init=pdivisors(1))
end

function solution(alimit, blimit)
    length(unique(divpow(a, b) for a in 2:alimit, b in 2:blimit))
end

const ALIMIT = 100
const BLIMIT = 100
println(solution(ALIMIT, BLIMIT))
