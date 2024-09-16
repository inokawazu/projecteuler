struct SpiralNumbers end

Base.iterate(_::SpiralNumbers) = ((0, 0), (0, 0, 0))

function Base.iterate(_::SpiralNumbers, (layer, x, y))
    l = layer

    nl = layer
    npos = (x, y)

    nl += x == y == l ? 1 : 0

    npos = (x, y) .+ 
    if x == l && -l < y < l
        (0, -1)
    elseif -l < x <= l && y == -l
        (-1, 0)
    elseif x == -l && -l <= y < l
        (0, 1)
    elseif -l <= x <= l && y == l
        (1, 0)
    end

    (npos, (nl, npos...))
end

function solution(input)
    @assert isodd(input)
    nlayers = (input - 1) ÷ 2
    
    spiralcoords = Iterators.takewhile(SpiralNumbers()) do coord
        all(coord) do elem
            abs(elem) <= nlayers
        end
    end

    return sum(enumerate(spiralcoords)) do (i, (x, y))
        abs(x) == abs(y) ? i : zero(i)
    end
end

const INPUT = 1001
println(solution(INPUT))
