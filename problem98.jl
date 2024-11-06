include("download_input.jl")
include("common.jl")

# @show reduce(concateprod, [1,2,3])
# exit()

using .WebInput

function get_intput(;
    url="https://projecteuler.net/resources/documents/0098_words.txt"
)
    rawinput = get_web_input(url)
    return map(split(rawinput, ",", keepempty=false)) do line
        strip(line, '"')
    end
end

function isanagram(s1, s2)
    return length(s1) == length(s2) && sort!(collect(s1)) == sort!(collect(s2))
end

function group(by::Function, v)
    groups = Vector{eltype(v)}[]

    for velem in v
        matchgroupi = findfirst(group -> by(first(group), velem), groups)
        if isnothing(matchgroupi)
            push!(groups, [velem])
        else
            push!(groups[matchgroupi], velem)
        end
    end

    return groups
end

# println(get_intput())

sqr(x) = x * x

function transition_perm(to, from)
    toIfromfrom = sortperm(collect(from))
    invpermute!(toIfromfrom, sortperm(collect(to)))
end

function maxanasqr!(anagrams, squares)
    maxsqr = -1
    sort!(squares)
    jdigits = zeros(Int, ndigits(first(squares)))

    for i in eachindex(anagrams)
        anai = anagrams[i]
        for j in i+1:length(anagrams)
            anaj = anagrams[j]
            tranp = transition_perm(anaj, anai)
            @assert collect(anaj) == collect(anai)[tranp] "$anaj <= $anai"
            for sqr in squares
                permute!(reverse!(digits!(jdigits, sqr)), tranp)
                candsqr = reduce(concateprod, jdigits)
                if allunique(jdigits) && insorted(candsqr, squares)
                    # @info "$anai, $sqr => $anaj, $candsqr"
                    maxsqr = max(candsqr, sqr, maxsqr)
                end
            end
        end
    end

    return maxsqr
end

function solution(input = get_intput())
    anagram_groups = filter(x->length(x)>1, group(isanagram, input))
    sort!(anagram_groups, by=length∘first)
    maxanalen = maximum(length∘first, anagram_groups)

    squares = Iterators.map(sqr, Iterators.countfrom(1))
    squares = Iterators.takewhile(n->ndigits(n) <= maxanalen, squares)

    sqr_groups = group((x,y) -> ndigits(x) == ndigits(y), squares)

    ndigs = 1
    maxsqr = -1
    for anagram_group in anagram_groups
        while ndigs < length(first(anagram_group))
            ndigs += 1
        end

        maxsqr = max(maxsqr, maxanasqr!(anagram_group, sqr_groups[ndigs]))
    end
    return maxsqr
end

println(solution())
