# [1, 2, 3]

function permutations(set, ch::AbstractChannel, cp = empty(set))
    if isempty(set)
        put!(ch, cp)
    end

    for i in eachindex(set)
        invi = setdiff(1:length(set), i)
        permutations(set[invi], ch, vcat(cp, set[i]))
    end
end

function permutations(set::T) where T
    ch = Channel{T}(0) do chan
        permutations(set, chan)
    end
    return ch
end

tonumber(v) = sum(zip(v, 0:length(v)-1)) do (b, e)
    b * 10^e
end

function hasspecialprop(pannumv)
    pnums = [2,3,5,7,11,13,17]
    Iterators.map(pnums, length(pannumv)-3:-1:1) do pnum, i
        tonumber(pannumv[i:i+2]) % pnum == 0
    end |> all
end

function solution()
    specialnumvs = Iterators.filter(permutations(collect(0:9))) do pannumv
        pannumv[1] != 0 && hasspecialprop(pannumv)
    end
    return sum(tonumber, specialnumvs)
end

println(solution())
