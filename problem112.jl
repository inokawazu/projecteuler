include("common.jl")

# idigits(n::T)

function isincreasing(n)
    ds = idigits(n)
    0 <= n < 10 || all(zip(ds, Iterators.drop(ds, 1))) do (d1, d2)
        d1 <= d2
    end
end

function isdecreasing(n)
    ds = idigits(n)
    0 <= n < 10 || all(zip(ds, Iterators.drop(ds, 1))) do (d1, d2)
        d1 >= d2
    end
end

isboucy(n) = !isincreasing(n) && !isdecreasing(n)

function solution(f::Rational{I} = 99//100) where I <: Integer
    nbouncy = 0
    ntotal = 0
    for n in Iterators.countfrom()
        ntotal += 1
        nbouncy += isboucy(n)
        if numerator(f) * ntotal <= nbouncy * denominator(f)
            return n
        end
    end
    return -1
end

println(solution())
