include("common.jl")

function find_prime_pairs(n::T) where T
    output = Tuple{T, T}[]
    for id in 1:ndigits(n)-1
        num1, num2 = divrem(n, 10^id)
        ldnum2 = div(num2, 10^(id-1))
        if !iszero(ldnum2) && all(isprime, (num1, num2))
            push!(output, (num1, num2))
        end
    end

    return output
end

# function get_nconnected_sets(pp, pp_graph, n)
#     return get_nconnected_sets(Set(pp), pp_graph, n-1)
# end

function get_nconnected_sets(pp::T, pp_graph, n) where T
    # if n == 0
    #     return [pp_set]
    # end

    output = [Set(pp)]
    n -= 1

    while n > 0
        pp_sets = copy(output)
        empty!(output)

        for pp_set in pp_sets
            if any(pp->!(pp in keys(pp_graph)), pp_set)
                continue
            end

            outwards = mapreduce(pp->pp_graph[pp], union, pp_set)
            setdiff!(outwards, pp_set)

            for outp in outwards
                if !(outp in keys(pp_graph))
                    continue
                elseif !issubset(pp_set, pp_graph[outp]) 
                    continue
                elseif !all(pp->outp in pp_graph[pp], pp_set) 
                    continue
                end

                cand_pp_set = union(pp_set, outp)
                if !any(pps->issetequal(cand_pp_set, pps), output)
                    push!(output, cand_pp_set)
                end
            end
        end

        n -= 1
    end

    return output

    # unique(issetequal,
    # Iterators.flatmap(outwards) do outp
    #     if !(outp in keys(pp_graph))
    #         T[]
    #     elseif !issubset(pp_set, pp_graph[outp]) 
    #         T[]
    #     elseif !all(pp->outp in pp_graph[pp], pp_set) 
    #         T[]
    #     else
    #         get_nconnected_sets(union(pp_set, outp), pp_graph, n-1)
    #     end
    # end)
end

# const MAX_REF = Ref(0)
# function isnconnected(pp, pp_graph, n)
    # if !(pp in keys(pp_graph))
    #     return false
    # end

    # pp_set = Set(pp)
    # union!(pp_set, pp_graph[pp])


    # if (Set(( 3,7,109,673 )) ⊆ pp_set)
    #     println(pp_set)
    #     for pp in pp_set
    #         if pp in keys(pp_graph)
    #             println(pp, " => ", pp_graph[pp])
    #         end
    #     end
    # end

    # return (Set(( 3,7,109,673 )) ⊆ pp_set)

    # filt_set = filter(pp_set) do opp
    #     opp_cnt = count(pp_set) do oopp
    #         opp == oopp ||
    #         oopp in keys(pp_graph) && opp in pp_graph[oopp]
    #     end
    #     opp_cnt > 5
    # end

    # return length(filt_set) >= n

    # intersect_set = mapreduce(intersect, pp_set) do opp
    #     opp_set = Set(opp)
    #     union!(opp_set, get(pp_graph, opp, empty(opp_set)))
    #     if pp == 673 
    #         println("DEBUG ", opp_set)
    #     end
    #     opp_set
    # end
    # return length(intersect_set) == n
# end

function solution(target::T = 5) where T
    nums = Iterators.countfrom(one(T))
    primes = Iterators.filter(isprime, nums)
    pp_graph = Dict{T, Set{T}}()

    for prime in primes
        if prime > 700_000
            foreach(x->println(x, "=>", filter(<=(673), sort(collect(pp_graph[x])))), [3,7,109,673])
            # @show isnconnected(673, pp_graph, target)
            return
        end

        for (ppl, ppr) in find_prime_pairs(prime)
            pp_graph[ppl] = push!(get(pp_graph, ppl, Set{T}()), ppr)

            ncsets = get_nconnected_sets(ppl, pp_graph, target)

            if !isempty(ncsets)
                println(ncsets)
                return minimum(sum, ncsets)
                # println(ppl," => ", pp_graph[ppl])
                # return ppl + sum(pp_graph[ppl])
            end
        end
    end
end

println(solution(4))
