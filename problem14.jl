struct CollatzSequence{T<:Integer}
    start::T

    function CollatzSequence(start::T) where T
        if start < 0
            throw(ArgumentError("`start` must be 1 or greater"))
        end
        return new{T}(start)
    end
end

function Base.iterate(cs::CollatzSequence)
    return (cs.start, cs.start)
end

function Base.iterate(::CollatzSequence{T}, state::T) where T
    if isone(state)
        return nothing
    else
        next = iseven(state) ? state÷2 : 3state+1
        return (next, next)
    end
end

Base.IteratorSize(::CollatzSequence) = Base.SizeUnknown()

function solution(limit)
    iterlen(iter) = count(_->true, iter)
    return argmax(1:(limit-1)) do n
        iterlen(CollatzSequence(n))
    end
end

const LIMIT = 1_000_000
println(solution(LIMIT))
