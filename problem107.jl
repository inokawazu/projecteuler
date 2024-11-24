include("download_input.jl")

using .WebInput

function get_input(url="https://projecteuler.net/resources/documents/0107_network.txt")
    raw_input = get_web_input(url)
    map(split(raw_input, "\n", keepempty=false)) do line
        map(split(line, ',')) do elem
            if all(isdigit, elem)
                parse(Int, elem)
            elseif elem == "-"
                0
            else
                error("unreachable")
            end
        end
    end |> stack
end

# A	B	C	D	E	F	G
# A	-	16	12	21	-	-	-
# B	16	-	-	17	20	-	-
# C	12	-	-	28	-	31	-
# D	21	17	28	-	18	19	23
# E	-	20	-	18	-	-	11
# F	-	-	31	19	-	-	27
# G	-	-	-	23	11	27	-

const TEST_INPUT = [
    0 16 12 21 0 0 0
    16 0 0 17 20 0 0
    12 0 0 28 0 31 0
    21 17 28 0 18 19 23
    0 20 0 18 0 0 11
    0 0 31 19 0 0 27
    0 0 0 23 11 27 0
]

@inline function cost(network)
    return sum(network) ÷ 2
end

@inline function remcost(network::AbstractMatrix{T}, ijs) where {T}
    sum(ijs; init=zero(T)) do (i, j)
        canremove(network, (i, j)) * network[i, j]
    end
end

@inline function canremove(network, (ir, jr))
    visited = falses(size(network, 1))
    queue = Int[jr]
    while !isempty(queue)
        j = popfirst!(queue)
        visited[j] = true
        for i in axes(network, 1)
            if !visited[i] && (i, j) != (ir, jr) && (i, j) != (jr, ir) &&
               !(iszero(network[i, j])) && !(i in queue)
                push!(queue, i)
            end
        end
    end

    return all(visited)
end

function solution(networkmat=get_input())
    initial_cost = cost(networkmat)
    best_cost = initial_cost

    trimmed_network = copy(networkmat)

    tovisit = [
        (i, j)
        for i in axes(trimmed_network, 1)
        for j in i+1:size(trimmed_network, 2)
        if !iszero(trimmed_network[i, j])
    ]
    sort!(tovisit, by=I -> trimmed_network[I...], rev=true)

    stack = [(1, :start)]
    while !isempty(stack)
        ij_ind, state = pop!(stack)
        i, j = tovisit[ij_ind]

        if state == :start
            if canremove(trimmed_network, (i, j))
                trimmed_network[j, i] = trimmed_network[i, j] = 0
                state = :remove
            else
                state = :ignore
            end
        elseif state == :remove
            trimmed_network[j, i] = trimmed_network[i, j] = networkmat[i, j]
            state = :ignore
        elseif state == :ignore
            state = :end
        else
            error("unreachable")
        end

        if cost(trimmed_network) < best_cost
            best_savings = initial_cost - cost(trimmed_network)
            @info "Found better cost!" best_savings = best_savings best_cost = cost(trimmed_network)
            best_cost = cost(trimmed_network)
        end

        if state != :end
            push!(stack, (ij_ind, state))
        end

        rcost = remcost(trimmed_network, @view(tovisit[ij_ind+1:end]))
        if cost(trimmed_network) >= best_cost + rcost
            continue
        end

        if ij_ind < length(tovisit)
            push!(stack, (ij_ind + 1, :start))
        end
    end

    return initial_cost - best_cost
end


# println(solution(TEST_INPUT))
println(solution())
