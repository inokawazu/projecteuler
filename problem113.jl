isincreasing(n) = all(>=(0), diff(reverse(digits(n))))
isdecreasing(n) = all(<=(0), diff(reverse(digits(n))))
isconst(n) = allequal(digits(n))
isboucy(n) = !isincreasing(n) && !isdecreasing(n)

function nincreasing(n::I) where I
    @assert n > 0

    start_with = zero(I)
    cache = Dict{Tuple{I, I}, Int}()

    function recurse(m::I, start_with::I = zero(I))
        if m == 1
            return 1
        elseif haskey(cache, (m, start_with))
            return cache[(m, start_with)]
        end

        cache[(m, start_with)] = sum(recurse(m - 1, sw) for sw in start_with:9)
    end

    recurse(n + 1) - 1
end


function ndecreasing(n::I) where I
    @assert n > 0

    cache = Dict{Tuple{I, I}, Int}()

    function recurse(m::I, start_with::I = 9one(I))
        if m == 1
            return 1
        elseif haskey(cache, (m, start_with))
            return cache[(m, start_with)]
        end

        cache[(m, start_with)] = sum(recurse(m - 1, sw) for sw in 0:start_with)
    end

    sum(recurse(m + 1) - 1 for m in 1:n)
end

nconst(n) = return 9n

# n is n in 10^n
function solution(n)
    nincreasing(n) + ndecreasing(n) - nconst(n)
end

println(solution(big(100)))
