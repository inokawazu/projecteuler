function eachdigit(n::I) where I <: Integer
    Channel{I}() do ch
        n = abs(n)
        while n > 0
            n, r = divrem(n, 10)
            push!(ch, r)
        end
    end
end

factorial_sum(n) = sum(factorial, eachdigit(n))

function solution(target::T=1_000_000) where T
    sol_cnt = 0
    cnt_target = 60
    cache = Dict{T, T}()

    nrts = Set{T}()
    for n in 1:target-1
        empty!(nrts)
        cnt = 0
        n_start = n

        while !(n in nrts) && !(n in keys(cache))
            cnt += 1
            push!(nrts, n)
            n = factorial_sum(n)
        end

        if n in keys(cache)
            cnt += cache[n]
        end

        if cnt == cnt_target
            sol_cnt += 1
        end

        cache[n_start] = cnt
    end

    return sol_cnt
end

println(solution())
