include("common.jl")

function solution(target::T = 5000) where T
    ways = Dict{Tuple{T, T}, T}()

    for n in Iterators.countfrom(1)
        for build in 1:n
            for limit in 1:n
                haskey(ways, (build, limit))

                nps = Iterators.filter(isprime, 1:min(limit, build))
                ways[(build, limit)] = sum(nps, init = zero(T)) do m
                    m == build ? one(T) : ways[(build - m, m)]
                end
            end
        end

        if n > 1 && ways[(n, n-1)] > target
            return n
        end
    end

end

println(solution())
