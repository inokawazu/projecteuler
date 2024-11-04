function divisors(n::Integer)
    @assert n > 0 "n = $n"
    Iterators.flatmap(1:isqrt(n)) do i
        d, r = divrem(n, i)
        if r != 0 || isone(n)
            tuple()
        elseif i == d || isone(i)
            (i,)
        else
            (i, d)
        end
    end
end

function next(n)
    sum(divisors(n), init=zero(n))
end

function solution(limit::T=1_000_000) where T
    # in!
    # chains = Vector{T}[]
    visited = Set{T}()

    longest_chain_len = 0
    longest_chain_min = 0
    
    for n in 2:limit
        n in visited && continue

        chain = T[n]
        primefound = false
        local nn

        while true
            if n > limit
                break
            end

            nn = next(n)
            primefound = isone(nn)

            if nn in chain || in!(nn, visited)
                break
            end

            push!(chain, nn)

            if primefound
                break
            end

            n = nn
        end

        if !primefound && nn in chain
            chain = chain[findfirst(==(nn), chain):end]
            if length(chain) > longest_chain_len
                longest_chain_min = minimum(chain)
                longest_chain_len = length(chain)
            end
        end
    end
    return longest_chain_min
end

println(solution())
