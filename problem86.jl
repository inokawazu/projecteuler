# sqrt(t^2 + b^2) + sqrt((a-t)^2 + c^2) = d
# t = a b / (b - c), a b / (b + c)
#
# valid t = a b / (b + c)
# sqrt(t^2 + b^2) + sqrt((a-t)^2 + c^2)
#
# going the other way t = a b / (a + c)
# sqrt(t^2 + a^2) + sqrt((b-t)^2 + c^2)
#
# going diagonal
# sqrt(b^2 + a^2) + c

issqr(n) = isqrt(n)^2 == n

function mindis1check(a, b, c)
    issqr((b + c)^2 + a^2)
end

function mindis1(a, b, c)
    sqrt((b + c)^2 + a^2)
end

function mindis2(a, b, c)
    sqrt(a^2 + b^2) + c
end

function mindis2check(a, b, _)
    issqr(a^2 + b^2)
end

@inline function ismin_intdis(a::T, b::T, c::T) where {T}
    mindis = Inf
    isint = false


    iter = (
        (mindis1(a, b, c), mindis1check(a, b, c)),
        (mindis1(b, a, c), mindis1check(b, a, c)),
        (mindis2(a, b, c), mindis2check(a, b, c)),
        (mindis1(b, c, a), mindis1check(b, c, a)),
        (mindis1(c, b, a), mindis1check(c, b, a)),
        (mindis2(b, c, a), mindis2check(b, c, a)),
        (mindis1(c, a, b), mindis1check(c, a, b)),
        (mindis1(a, c, b), mindis1check(a, c, b)),
        (mindis2(c, a, b), mindis2check(c, a, b)),
    )

    for (dis, check) in iter
        if dis < mindis
            mindis = dis
            isint = check
        end
    end

    return isint
end

function solution(target::T=1_000_000) where {T}
    prev = zero(T)

    for M in Iterators.countfrom(one(T))
        miterss = ((
            ((c, c, c) for c in M:M),
            ((a, M, M) for a in 1:M-1),
            ((a, b, M) for a in 1:M-1 for b in a:M-1),
        ))
        for abcs in miterss
            for (a, b, c) in abcs
                prev += ismin_intdis(a, b, c)
            end
        end

        if prev > target
            return M
        end
    end
end

println(@time solution())
println(@time solution())
