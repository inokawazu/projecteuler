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

const TEST_INPUT = [
    0 16 12 21 0 0 0
    16 0 0 17 20 0 0
    12 0 0 28 0 31 0
    21 17 28 0 18 19 23
    0 20 0 18 0 0 11
    0 0 31 19 0 0 27
    0 0 0 23 11 27 0
]

function find_parent!(parent, i)
    if parent[i] != i
        parent[i] = find_parent!(parent, parent[i])
    end
    return parent[i]
end

function union_parent!(parent, rank, x, y)
    if rank[x] < rank[y]
        parent[x] = y
    elseif rank[x] > rank[y]
        parent[y] = x
    else
        parent[y] = x
        rank[x] += 1
    end
end

function solution(networkmat::AbstractMatrix{T}=get_input()) where {T}
    result = Tuple{Int,Int,T}[]
    i = 1
    e = 0
    nverts = size(networkmat, 1)
    @assert allequal(size(networkmat))

    graph = [
        (i, j, networkmat[i, j])
        for i in axes(networkmat, 1) for j in i+1:nverts
        if !iszero(networkmat[i, j])
    ]
    sort!(graph, by=last)

    parent = collect(1:nverts)
    rank = zeros(Int, nverts)

    while e + 1 < nverts

        u, v, w = graph[i]
        i = i + 1
        x = find_parent!(parent, u)
        y = find_parent!(parent, v)

        if x != y
            e += 1
            push!(result, (u, v, w))
            union_parent!(parent, rank, x, y)
        end
    end

    return sum(last, result)
end

println(solution())
