include("download_input.jl")

using .WebInput

const URL = "https://projecteuler.net/resources/documents/0083_matrix.txt"

function get_input(url = URL)
    raw_input = get_web_input(url)
    rows = map(split(raw_input, "\n", keepempty=false)) do line
        parse.(Int, split(line, ",", keepempty=false))
    end
     stack(rows, dims=1)
end

function solution(input = get_input())
    T = eltype(input)

    @assert allequal(size(input))

    dim = size(input, 1)
    best_path_sum = typemax(T)
    best_sums = fill(typemax(T), size(input))

    # println(best_path_sum)

    start = CartesianIndex(1, 1)
    finis = CartesianIndex(dim, dim)
    
    directions = [
                  CartesianIndex(0,1)
                  CartesianIndex(1,0)
                  CartesianIndex(-1,0)
                  CartesianIndex(0,-1)
                 ]

    stack = [(start, 1, 0)]

    best_path = []

    while !isempty(stack)
        loc, dir_ind, tot = pop!(stack)
        ntot = tot + input[loc]

        if ntot > best_sums[loc]
            continue
        else
            best_sums[loc] = ntot
        end

        if ntot > best_path_sum
            continue
        end

        if loc == finis
            best_path_sum = ntot
            empty!(best_path)
            append!(best_path, stack)
            # println("Winner:", best_path_sum)
            continue
        end
        
        if dir_ind <= 4
            push!(stack, (loc, dir_ind + 1, tot))
            nloc = loc + directions[dir_ind]
            if checkbounds(Bool, input, nloc) && all(l->l[1] != nloc, stack)
                push!(stack, (nloc, 1, ntot))
            end
        end
    end

    println(join((Tuple∘first).(best_path), " -> "))

    path_mat = falses(size(input))
    path_mat[first.(best_path)] .= true
    foreach(eachrow(path_mat)) do row
        foreach(row) do elem
            print(elem ? "." : " ")
        end
        println()
    end

    return best_path_sum
end

const TESTINPUT = [
             131 673 234 103 18
             201 96 342 965 150
             630 803 746 422 111
             537 699 497 121 956
             805 732 524 37 331
            ]

println(solution())
