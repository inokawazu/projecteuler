# NOTES
# There must be no duplicates.
# No number must smaller than any two numbers.
# All two numbers must must be greater than all one numbers
# Etc for three to two and onwards

function subsets(elems, m, n)
    @assert n >= m
    let elems = copy(elems), VT = Vector{eltype(elems)}
        Channel{VT}() do ch
            v = VT(undef, n)

            function f!(i=1, j=0)
                if i > n
                    put!(ch, copy(v))
                    return
                elseif i > m
                    put!(ch, v[1:i-1])
                end

                for j_next in j+1:length(elems)
                    v[i] = elems[j_next]
                    f!(i + 1, j_next)
                end
            end
            f!()
        end
    end
end

function combinations(elems, n)
    let elems = copy(elems), VT = Vector{eltype(elems)}
        Channel{VT}() do ch
            v = VT(undef, n)

            function f!(i=1, j=0)
                if i > n
                    put!(ch, copy(v))
                    return
                end

                for j_next in j+1:length(elems)
                    v[i] = elems[j_next]
                    f!(i + 1, j_next)
                end
            end
            f!()
        end
    end
end

function check_rules(set)
    for subset1 in subsets(set, 1, length(set))
        card1 = length(subset1)
        for subset2 in subsets(setdiff(set, subset1), 1, card1)
            card2 = length(subset2)
            if sum(subset1) == sum(subset2)
                return false
            end
            if card1 > card2 && sum(subset1) <= sum(subset2)
                return false
            end
        end
    end
    return true
end

function addsetunique(set, i)
    set = copy(set)

    set[i] += 1
    i += 1

    while i <= length(set) && set[i] == set[i-1]
        set[i] += 1
        i += 1
    end
    set
    # return (set, sum(set))
end

function minussetunique(set, i)
    set = copy(set)

    set[i] -= 1
    i -= 1

    while 1 <= i && set[i] == set[i+1]
        set[i] -= 1
        i -= 1
    end
    return set
end

function visitedhash(set)
    join(sort(set))
end

function solution(n=7, range=20:50)
    # special_set = collect(1:1)
    # for m in 2:n
    #     special_set
    #     mid_ind = cld(length(special_set), 2) + iseven(length(special_set))
    #     b = special_set[mid_ind]
    #     special_set = [b; b .+ special_set]
    #     @assert check_rules(special_set) "Failed for n=$m, set=$special_set"
    # end

    # minsum = sum(special_set)
    # minset = special_set
    # queue = [special_set]
    # visited = Set{String}((visitedhash(special_set),))

    # min_bound = 9 * minsum ÷ 10
    # min_bound = 254 # 9 * minsum ÷ 10

    noriginal = nleft = binomial(big(length(range)), n)

    function local_check_rules(s)
        res = check_rules(s)
        nleft -= 1
        @info "$nleft/$noriginal left, $(round(nleft/noriginal*100, digits=2))% left"

        return res
    end

    minset = argmin(sum, Iterators.filter(local_check_rules, combinations(collect(range), n)))

    # while !isempty(queue)
    #     set = popfirst!(queue)
    #     @show set, sum(set), length(queue)
    #     if sum(set) < minsum && check_rules(set)
    #         @show minsum = sum(set)
    #         @show minset = set
    #         @info "Found new min $(visitedhash(set)), queue length = $(length(queue))"
    #     end
    #     nextsets = Iterators.flatmap(eachindex(set)) do i
    #         (
    #          minussetunique(set, i),
    #          addsetunique(set, i),
    #         )
    #     end
    #     for nextset in nextsets
    #         if in!(visitedhash(nextset), visited) || !issubset(nextset, 20:50) || iszero(first(nextset)) || sum(nextset) > minsum
    #             continue
    #         else
    #             push!(queue, nextset)
    #         end
    #     end
    # end

    return visitedhash(minset)

    # while !isempty(queue)
    #     set = popfirst!(queue)
    #     # @info "visiting $(set), queue length = $(length(queue))"
    #     if check_rules(set)
    #         return visitedhash(set)
    #     end

    #     nextones = map(eachindex(set)) do i
    #         addsetunique(set, i)
    #     end

    #     sort!(nextones, by=last)

    #     for nextone in nextones
    #         nextset = first(nextone)
    #         # if visitedhash(nextset) in visited
    #         if in!(visitedhash(nextset), visited)
    #             # @info "skipping $(nextset) since visited."
    #             continue
    #         else
    #             push!(queue, nextset)
    #         end
    #     end
    # end


    # special_set0 = collect(1:1)

    # for _ in 2:n
    #     @show special_set0
    #     special_set0 = [special_set0; last(special_set0) + 1]

    #     queue = [special_set0]
    #     visitedhash(special_set0)
    #     visited = Set{String}((visitedhash(special_set0),))

    #     while !isempty(queue)
    #         set = popfirst!(queue)
    #         # @info "visiting $(set), queue length = $(length(queue))"
    #         if check_rules(set)
    #             special_set0 = set
    #             break
    #         end

    #         nextones = map(eachindex(set)) do i
    #             addsetunique(set, i)
    #         end

    #         sort!(nextones, by=last)

    #         for nextone in nextones
    #             nextset = first(nextone)
    #             # if visitedhash(nextset) in visited
    #             if in!(visitedhash(nextset), visited)
    #                 # @info "skipping $(nextset) since visited."
    #                 continue
    #             else
    #                 push!(queue, nextset)
    #             end
    #         end
    #     end
    # end
    # return special_set0

    # @show check_rules([1])
    # @show check_rules([1, 2])
    # @show check_rules([1, 2, 3])
    # @show check_rules([2, 3, 4])
    # foreach(println, subsets(special_set, 1, n))
end

println(solution())
