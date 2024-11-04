# https://www.desmos.com/calculator/hibjvkvspu?lang=ja

# function extended_gcd(a, b)
function extended_gcd(a::T, b::U) where {T,U}
    V = promote_type(T, U)
    #
    (old_r, r) = (V(a), V(b))
    (old_s, s) = (one(V), zero(V))
    (old_t, t) = (zero(V), one(V))

    #     while r ≠ 0 do
    while !iszero(r)
        # #
        quotient = old_r ÷ r
        #         (old_r, r) := (r, old_r − quotient × r)
        #         (old_s, s) := (s, old_s − quotient × s)
        #         (old_t, t) := (t, old_t − quotient × t)
        (old_r, r) = (r, old_r − quotient * r)
        (old_s, s) = (s, old_s − quotient * s)
        (old_t, t) = (t, old_t − quotient * t)
    end

    #     output "Bézout coefficients:", (old_s, old_t)
    #     output "greatest common divisor:", old_r
    #     output "quotients by the gcd:", (t, s)
    (
        bezout_coefs=(old_s, old_t),
        gcd=old_r,
        gcd_quotients=(t, s),
    )
end

function isgooddisks(x, y)
    x * (x - 1) == (x + y) * (x + y - 1) ÷ 2
end

function isgooderr(x, y)
    x * (x - 1) - (x + y) * (x + y - 1) ÷ 2
end


# 1 / 2 - x - Sqrt[1 - 8 x + 8 x ^ 2] / 2
# 1 / 2 - x + sqrt(2) x
# 1 / 2 + x (sqrt(2) - 1)
# y = 1 / 2 + x n/d
# 2y = 1 + x 2n/d
# 2dy = d + x 2n
# 2dy - 2nx = d
function solution(min=big"10"^12)
    setprecision(100, base=100) do

        seed = (sqrt(big"2") - 1)

        for pre in 2:30
            r = rationalize(seed, tol=10.0^(-pre))

            ndis = 0
            for n in numerator(r)-ndis:numerator(r)+ndis
                for d in denominator(r)-ndis:denominator(r)+ndis
                    a, b = -2n, 2d
                    cd = abs(gcd(a, b))
                    if mod(d, cd) == 0
                        x, y = extended_gcd(a, b).bezout_coefs
                        @assert a < 0

                        while y < 0 || x < 0
                            x, y = x + b ÷ cd, y - a ÷ cd
                        end

                        @show x, y

                        if x + y > min && isgooddisks(x, y)
                            return x
                        elseif y + x > min
                            @show isgooderr(x, y), isgooderr(y, x)
                        end
                    end
                end
            end
        end
    end
end

println(solution())
