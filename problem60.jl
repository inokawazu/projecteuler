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

function solution(target::T = 5) where T
    nums = Iterators.countfrom(one(T))
    primes = Iterators.filter(isprime, nums)
    pp_graph = Dict{T, Set{T}}()

    for prime in primes
        # if prime > 1_000_000
        #     foreach(x->println(x, "=>", filter(<=(673), sort(collect(pp_graph[x])))), [3,7,109,673])
        #     return
        # end

        for (ppl, ppr) in find_prime_pairs(prime)
            pp_graph[ppl] = push!(get(pp_graph, ppl, Set{T}()), ppr)

            # length(pp_graph[ppl]) >= target - 1 || continue
            # pp_set = union(Set(ppl), pp_graph[ppl])
            # @assert length(pp_set) >= target
            
            # return ppl, pp_set

            # all(pp_set) do pp
            #      pp in keys(pp_graph) && length(pp_graph[pp]) >= target - 1
            # end || continue

            # intersect_ppset = mapreduce(intersect, pp_set) do opp
            #     union(Set(opp), pp_graph[opp])
            # end

            # if Set((3, 7, 673)) ⊆ intersect_ppset
            #     return intersect_ppset
            # end

            # if Set((3,7,109,673)) ⊆ pp_set
            #     return 
            # end

            # return foreach(collect(pp_set)) do pp
            #     pp_graph[pp]
            # end

            # if ppl == 673
            #     @show 673, pp_set
            #     foreach(pp_set) do opp
            #         @show opp, filter(<=(673), pp_graph[opp])
            #     end
            # end
            
            # intersect_ppset = mapreduce(intersect, pp_set) do opp
            #     union(Set(opp), pp_graph[opp])
            # end

            # if length(intersect_ppset) >= target
            #     println(pp_set)
            #     for ppn in pp_graph[ppl]
            #         println(pp_graph[ppn])
            #     end
            #     return sum(intersect_ppset)
            # end

            # all_connected = all(pp_set) do pp
            #     pp in keys(pp_graph) &&
            #     ⊆(setdiff(pp_set, pp), pp_graph[pp])
            # end
            
            # alltarget = all(ppl_neighs) do ppl_neigh
            #     pp_neighbor in keys(pp_graph) &&
            #     pp in pp_graph[pp_neighbor] &&
            #     all(other_neighbor -> 
            #         other_neighbor == pp_neighbor ||
            #         pp_neighbor in keys(pp_neighbor) &&
            #         other_neighbor in pp_graph[pp_neighbor], pp_graph[pp])
            # end


            # pp_graph[ppr] = push!(get(pp_graph, ppr, Set{T}()), ppl)
            # for pp in (ppl, ppr)
            #     length(pp_graph[pp]) != target - 1 && continue

            #     alltarget = all(pp_graph[pp]) do pp_neighbor
            #         pp_neighbor in keys(pp_graph) &&
            #         pp in pp_graph[pp_neighbor] &&
            #         all(other_neighbor -> 
            #             other_neighbor == pp_neighbor ||
            #             pp_neighbor in keys(pp_neighbor) &&
            #             other_neighbor in pp_graph[pp_neighbor], pp_graph[pp])
            #     end

            #     if alltarget
            #         for ppn in pp_graph[pp]
            #             println(pp_graph[ppn])
            #         end
            #         println([pp; collect(pp_graph[pp])])
            #         return sum(pp_graph[pp]) + pp
            #     end
            # end
        end
        
        # mapreduce(intersect, pairs(pp_graph)) do (ppl, ppr_set)
        #     union(Set(opp), ppr_set)
        # end
    end
end

println(solution(4))
