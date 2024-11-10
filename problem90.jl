include("common.jl")

const SQUARES = map(1:9) do i
    sqr = i^2
    divrem(sqr, 10)
end

function combinations(elems, n)
    let elems = copy(elems), VT = Vector{eltype(elems)}
        Channel{VT}() do ch
            v = VT(undef, n)

            function f!(i=1, j=0)
                if i > n # all(!=(NotFilled(), v))
                    put!(ch, copy(v))
                    return
                end

                for j_next in j+1:length(elems)
                    v[i] = elems[j_next]
                    f!(i + 1, j_next)
                end
            end
            f!()
        end
    end
end

function snflip(n::T)::T where T
    # n * (n != 6) * (n != 9) + 9 * (n == 6) + 6 * (n == 9)
    if n == 6
        return 9one(T)
    elseif n == 9
        return 6one(T)
    else
        return n
    end
end

hasside(dice, side) = side in dice || snflip(side) in dice

function valid(c1, c2)
    return all(
               hasside(c1, x) && hasside(c2, y) || 
               hasside(c2, x) && hasside(c1, y) 
               for (x, y) in SQUARES
              )
end

function solution()
    cubes = collect(combinations(0:9, 6))
    cube_pairs = (
        (c1, c2) for (i, c1) in enumerate(cubes) for c2 in cubes[begin:i]
    )
    count(cube_pairs) do cp
        valid(cp...)
    end
end

println(solution())
