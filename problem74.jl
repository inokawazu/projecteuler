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

    nrts = Set{T}()
    for n in 1:target-1
        n % 10000 == 0 && @show n

        cnt = 0
        empty!(nrts)

        while !(n in nrts) && cnt <= cnt_target
            cnt += 1
            push!(nrts, n)
            n = factorial_sum(n)
        end

        if cnt == cnt_target
            sol_cnt += 1
        end
    end

    return sol_cnt
end

println(solution())
