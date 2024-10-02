function phi(n::T) where T <: Integer
    pro = one(T)
    maxi = isqrt(n)

    for p in Iterators.countfrom(2one(T))
        k = zero(T)

        while mod(n, p) == 0
            n ÷= p
            k += 1
        end

        if k > 0
            pro *= p^(k-1) * (p - 1)
        elseif isone(n)
            break
        elseif p == maxi
            pro *= (n - 1)
            n ÷= n
            break
        end
    end

    return pro
end

nphi(n) = n / phi(n)

function solution(target = 1_000_000)
    return argmax(2:target) do n
        nphi(n)
    end
end

println(solution())
