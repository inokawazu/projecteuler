function isprime(n)
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

function tonumber(digs)
    sum(zip(0:length(digs)-1, digs)) do ( e, b )
        10 ^ e * b
    end
end

function iscircular(n)
    ds = digits(n)
    all(0:ndigits(n)-1) do r
        isprime(tonumber(circshift(ds, r)))
    end
end

function solution(limit = 1_000_000)
    return count(iscircular, 1:limit-1)
end

println(solution())
