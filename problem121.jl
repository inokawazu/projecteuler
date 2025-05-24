# 1/2 1/2
# 1/3 2/3
# 1/4 3/4
# 1/(m + 2) (m + 1)/(m + 2)

# how many ways to win for (n rounds left, r red taken, b blue taken)
function ways2win(n::T, r = T(0), b = T(0)) where T
    @assert n >= 0
    if n == 0
        return b > r ? one(T) : zero(T)
    end

    m = r + b
    return ways2win(n - 1, r, b + 1) + (m + 1) * ways2win(n - 1, r + 1, b)
end

function totalways(n)
    factorial(n+1)
end

function solution(n)
    totalways(n) ÷ ways2win(n)
end

println(solution(15))
