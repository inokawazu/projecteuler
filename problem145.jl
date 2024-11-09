include("common.jl")


function solution(target=1_000_000_000)
    tsks = map(round_robin_inds(1, target)) do rng
        Threads.@spawn count(rng) do n
            !iszero(mod(n, 10)) && all(isodd, idigits(revdigits(n) + n))
        end
    end

    sum(fetch, tsks)
end

println(@time solution(1_000_000_000))
