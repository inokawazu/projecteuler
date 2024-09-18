include("download_input.jl")

using .WebInput

function parse(raw_input)
    map(split(strip(raw_input), ',')) do raw_word
        strip(raw_word, '"')
    end
end

const INPUT = parse(get_web_input("https://projecteuler.net/resources/documents/0042_words.txt"))

trianglenumber(n) = n * (n+1) ÷ 2

function solution(input)
    longestwordlen = maximum(length, input)
    alpha = 'A':'Z'
    maxwordvalue = length(alpha) * longestwordlen

    trinums = Iterators.map(trianglenumber, Iterators.countfrom())

    triset = Set(Iterators.takewhile(<=(maxwordvalue), trinums))
    wordvalues = Dict(zip(alpha,1:length(alpha)))

    count(input) do word
        wordvalue = sum(c -> wordvalues[c], word)
        wordvalue in triset
    end
end

println(solution(INPUT))
