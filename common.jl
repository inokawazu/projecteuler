function concateprod(a, b)
    a * 10^ndigits(b) + b
end

function ispandigital(n, b=9)
    ds = digits(n)
    allunique(ds) && issetequal(ds, 1:b)
end

function isprime(n)
    n = abs(n)
    if n < 2
        return false
    end

    for i in 2:isqrt(n)
        if mod(n, i) == 0
            return false
        end
    end
    return true
end
