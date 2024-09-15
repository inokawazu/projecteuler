include("download_input.jl")
using .WebInput

function parse_input(raw_input)
    map(split(raw_input, ',')) do qword
        strip(qword, '"')
    end
end

function alphabetical_value(s)
    sum(s) do c
        c - 'A' + 1
    end
end

function solution(input)
    ranks = invperm(sortperm(input))

    sum(zip(ranks, input)) do (rank, word)
        rank * alphabetical_value(word)
    end
end

const URL ="https://projecteuler.net/resources/documents/0022_names.txt"
const INPUT = parse_input(get_web_input(URL))
println(solution(INPUT))
