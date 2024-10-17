include("download_input.jl")

using .WebInput

const URL = "https://projecteuler.net/resources/documents/0081_matrix.txt"

function get_input(url = URL)
    raw_input = get_web_input(url)
    rows = map(split(raw_input, "\n", keepempty=false)) do line
        parse.(Int, split(line, ",", keepempty=false))
    end
     stack(rows, dims=1)
end

function solution(input = get_input())
    T = eltype(input)

    sums = similar(input)
    fill!(sums, zero(T))

    @assert allequal(size(input))

    dim = size(input, 1)
    for n in 1:dim
        inds = Iterators.flatten((
                                 (CartesianIndex(n, j) for j in n:dim),
                                 (CartesianIndex(i, n) for i in n:dim)
                                ))
        for ind in inds
            upind = ind + CartesianIndex(0, -1)
            leftind = ind + CartesianIndex(-1, 0)
            hasup = checkbounds(Bool, sums, upind)
            hasleft = checkbounds(Bool, sums, leftind)

            sums[ind] = input[ind] + if !hasup && hasleft
                sums[leftind]
            elseif hasup && !hasleft
                sums[upind]
            elseif !hasup && !hasleft
                zero(T)
            else
                min(sums[upind], sums[leftind])
            end

        end
    end

    # display(sums)
    return sums[dim, dim]
end

const TESTINPUT = [
             131 673 234 103 18
             201 96 342 965 150
             630 803 746 422 111
             537 699 497 121 956
             805 732 524 37 331
            ]

println(solution())
