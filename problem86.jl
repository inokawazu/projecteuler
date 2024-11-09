@inline issqr(n) = isqrt(n)^2 == n
@inline discheck((a, b, c)) = issqr((a + b)^2 + c^2)

function solution(target::T=1_000_000) where {T}
    prev = zero(T)
    for M in Iterators.countfrom(one(T))
        prev += count(discheck, ((a, b, M) for a in 1:M for b in a:M))
        if prev > target
            return M
        end
    end
end

println(solution())
