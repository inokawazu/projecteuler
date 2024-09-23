include("common.jl")

function numreverse(n::T) where T
    return digs2num(T.(reverse!(digits(n))))
end

ispalindrome(n) = n == numreverse(n)

function islychrel(n)
    n = big(n)
    limit = 49*one(n)
    for _ in 1:limit
        n += numreverse(n)
        if ispalindrome(n)
            return false
        end
    end
    return true
end

function solution()
    limit = 10_000
    return count(islychrel, 1:limit-1)
end

println(solution())
