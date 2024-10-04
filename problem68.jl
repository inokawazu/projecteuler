function makengon(n)
    return fill(-1, n, 2)
end

function getrow(ngon::AbstractMatrix, i)
    @assert size(ngon, 2) == 2 "Number of columns is not 2."
    nrows = size(ngon, 1)
    @assert 1 <= i <= nrows

    [ ngon[i, :]; ngon[mod1(i+1, nrows), 2] ]
end

function ismagicngon(ngon)
    return -1 in ngon || allequal(sum(row) for row in getrows(ngon))
end


function allmagicngons(n)
    Channel{Matrix{Int}}() do ch
        function _magicf!(ngon, pos)

            if !(-1 in ngon)
                @assert ismagicngon(ngon)
                @assert pos == length(ngon) + 1
                push!(ch, copy(ngon))
                return
            end

            nums = 1:length(ngon)
            for j in nums
                if j in ngon
                    continue
                end
                @assert ngon[pos] == -1

                ngon[pos] = j
                if ismagicngon(ngon)
                    _magicf!(ngon, pos + 1)
                end
                ngon[pos] = -1
            end

            return
        end

        start_ngon = makengon(n)
        _magicf!(start_ngon, 1)
    end
end

function getrows(ngon)
    n = size(ngon, 1)
    map(1:n) do i
        getrow(ngon, mod1(i, n))
    end
end

function solution(target = 5)

    sols = Iterators.map(getrows, allmagicngons(target))

    sols = Iterators.filter(sols) do sol
        findmin(first, sol)[2] == 1
    end

    sols = Iterators.map(x -> parse(BigInt, join(reduce(vcat, x))), sols)
    sols = Iterators.filter(x -> ndigits(x) == 16, sols)
    sol = maximum(sols)
    sol
end

println(solution())
