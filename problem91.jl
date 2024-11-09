function tdot(v1, v2)
    sum(v1 .* v2)
end

function isright(p1, p2, p3)
    return iszero(tdot(p1 .- p3, p2 .- p3)) ||
           iszero(tdot(p2 .- p1, p3 .- p1)) ||
           iszero(tdot(p3 .- p2, p1 .- p2))
end

function triorientation((x1, y1), (x2, y2), (x3, y3))
    return sign(x1 * y2 - x1 * y3 - x2 * y1 + x2 * y3 + x3 * y1 - x3 * y2)
end

const Point2D{T} = Tuple{T,T}
const Triangle2D{T} = Tuple{Point2D{T},Point2D{T},Point2D{T}}
function solution(limitx::T=50, limity::T=limitx) where {T}
    p1 = (zero(T), zero(T))
    pnts = Iterators.product(zero(T):limitx, zero(T):limity)
    count(Iterators.product(pnts, pnts)) do (p2, p3)
        triorientation(p1, p2, p3) > 0 && isright(p1, p2, p3)
    end
end

println(solution())
