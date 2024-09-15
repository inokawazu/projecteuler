function nproperdivisors(n::Integer)
    if n < 2
        return zero(n)
    end

    sum(2:isqrt(n), init = one(n)) do i
        d, r = divrem(n, i)
        if iszero(r) && d == i
            i
        elseif iszero(r)
            i + d
        else
            zero(n)
        end
    end
end

function isabundant(n)
    nproperdivisors(n) > n
end

function isabundant_summable(n::Integer)
    any(12:n÷2) do i
        isabundant(i) && isabundant(n - i)
    end
end

function solution()
    notas = Iterators.filter(!isabundant_summable, 1:28123)
    return sum(notas)
end

println(solution())
