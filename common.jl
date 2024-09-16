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
