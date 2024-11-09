# 0 < a <= b,  c
# dis left
# sqrt(x^2 + b^2) + sqrt((x - a)^2 + c^2)
# dis right
# sqrt(x^2 + a^2) + sqrt((x - b)^2 + c^2)
# min left dis 
# sqrt(1 + a^2/(b ± c)^2) * (b + c)
# min right dis 
# sqrt(1 + b^2/(a ± c)^2) * (a + c)

# min left dis squared
# ( 1 + a^2/(b ± c)^2 ) * (b + c)^2
# min left right squared
# (1 + b^2/(a ± c)^2) * (a + c)^2

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

# function mindisint1(a, b, c)
#     isqrt((b + c)^2 + a^2)
# end

function mindis1check(a, b, c)
    issqr((b + c)^2 + a^2)
end

function mindis1(a, b, c)
    sqrt((b + c)^2 + a^2)
end

# function mindisint2(a, b, c)
#     isqrt(a^2 + b^2) + c
# end

function mindis2(a, b, c)
    sqrt(a^2 + b^2) + c
end

function mindis2check(a, b, _)
    issqr(a^2 + b^2)
end

# function intmindis1(a, b, c)
#     (b * isqrt((b + c)^2 + a^2) + c * isqrt((b + c)^2 + a^2)) ÷ (b + c)
# end

# function mindis1(a, b, c)
#     (b * sqrt((b + c)^2 + a^2) + c * sqrt((b + c)^2 + a^2)) / (b + c)
# end

# function mindis2(a, b, c)
#     sqrt(b^2 + a^2) + c
# end

function ismin_intdis(a::T, b::T, c::T) where {T}

    (last ∘ argmin)(first,
        Iterators.flatmap(((a, b, c), (b, c, a), (c, a, b))) do (aa, ba, ca)
            (
                (mindis1(aa, ba, ca), mindis1check(aa, ba, ca)),
                (mindis1(ba, aa, ca), mindis1check(ba, aa, ca)),
                (mindis2(aa, ba, ca), mindis2check(aa, ba, ca)),
            )
        end
    )
end

function isroteqal(x1, x2)
    l = length(x1)
    l == length(x2) &&
        any(1:l) do offset
            all(zip(1:l, 1:l)) do (i, j)
                x1[mod1(i + offset, l)] == x2[j]
            end
        end
end


function solution(target::T=1_000_000) where {T}
    prev = zero(T)

    for M in Iterators.countfrom(one(T))
        @show M, prev
        a = M

        # mfound = Set{Tuple{T,T,T}}()

        miter = (M:M, 1:M-1)

        for miters in Iterators.product(miter, miter, miter)
            all(m -> !(M in m), miters) && continue
            for (a, b, c) in Iterators.product(miters...)

                found = a == b == c == M && ismin_intdis(a, b, c) ||
                        a < M && b == c == M && ismin_intdis(a, b, c) ||
                        a <= b < M && c == M && ismin_intdis(a, b, c)

                # if a < M && b < M && c == M && a == b
                #     @show M, (a,b,c)
                # end

                # found |= a > c < M && b == M && ismin_intdis(a, b, c)
                # found = a<=b<=c && ismin_intdis(a, b, c)

                if found
                    prev += 1
                end

                # isdup() = any(o -> isroteqal(o, (a, b, c)), mfound) ||
                #           in!((a, b, c), mfound)

                # if found && isdup()
                #     @error "$((a, b, c)) duplicated"
                #     exit(1)
                # end
            end
        end

        if prev > target
            # @show M, prev
            return M
        end
        # @show M, prev
    end
end

println(solution(2000))
# println(solution(1_000_000))
