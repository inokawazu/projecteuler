# b == number of blue
# r == number of red
# P, probability of drawing a blue twice in a row = b/(b + r) * (b-1)/(b + r - 1)
# t = r + b ≡ total
# equate P to 1/2 P = 1/2 ⟹   2 * b * (b-1) =  t * (t - 1)
# ⟹  (1 + sqrt(1 - 2 t + 2 t^2))/2
# ≡ (1 + d)/2 if t square where t = d^2 
# or ⟹  2b^2 - 2b = t^2 - t

function hasb(t::Integer)
    dsqr = 1 - 2 * t + 2 * t^2
    d = isqrt(dsqr)
    d^2 == dsqr && isodd(d)
end

function getb(t::Integer)
    (1 + isqrt(1 - 2 * t + 2 * t^2)) ÷ 2
end

function toprime(tb)
    @. 2 * tb - 1
end

function fromprime(tbp)
    @. div(tbp + 1, 2)
end

function qformp((tp, bp))
    # bp / 2 + 1 / 2 == b
    # (tp / 2 + 1 / 2) * (tp / 2 - 1 / 2) - 2(bp / 2 + 1 / 2) * (bp / 2 - 1 / 2) == 0
    # tp^2 - 2bp^2 == -1
    # x^2 - ny^2 == -1
    tp^2 - 2bp^2 + 1
end

function nextbpsol((xk, yk), (x1, y1); n=2)
    # x^2 - ny^2 == - 1
    xkp2 = xk * x1^2 + n * xk * y1^2 + 2n * yk * y1 * x1
    ykp2 = yk * x1^2 + n * yk * y1^2 + 2xk * y1 * x1
    return xkp2, ykp2
end

function solution(target=big(10)^12)
    ts = Iterators.filter(hasb, Iterators.countfrom(one(target)))

    t = first(ts)
    b = getb(t)

    tbp1 = tbp = toprime((t, b))

    while !(all(isodd, tbp) && fromprime(tbp[1]) > target)
        tbp = nextbpsol(tbp, tbp1)
        # @assert iszero(qformp(tbp))
    end

    return last(fromprime(tbp))

end

println(solution())
