
include("download_input.jl")

using .WebInput

const URL = "https://projecteuler.net/resources/documents/0082_matrix.txt"

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

    sums[:, 1] = input[:, 1]

    dim = size(input, 1)

    # sums[1, i>2] = min(sums[1,i-1], sums[2,i]) + input[1, i]
    # sums[end, i>2] = min(sums[end,i-1], sums[end-1,i]) + input[end, i]
    # sums[1<j<end, i>2] = min(sums[j,i-1], sums[j-1, 1], sums[j+1, 1]) + input[end, i]

    for c in 2:dim
        for r in 1:dim
            rmin = if r > 1
                min(sums[r-1, c], sums[r, c-1])
            else
                sums[r, c-1]
            end

            restrmin = 0
            for rp in r+1:dim
                restrmin += input[rp, c]
                rmin = min(rmin, restrmin + sums[rp, c-1])
                # if restrmin + sums[rp, c-1] >= rmin
                #     break
                # else
                #     rmin = restrmin + sums[rp, c-1]
                # end
            end

            sums[r, c] = rmin + input[r, c]
        end
    end

    return minimum(sums[:, dim])
end

const TESTINPUT = [
             131 673 234 103 18
             201 96 342 965 150
             630 803 746 422 111
             537 699 497 121 956
             805 732 524 37 331
            ]

println(solution())
