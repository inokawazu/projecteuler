include("download_input.jl")

using .WebInput

function get_intput(;
    url="https://projecteuler.net/resources/documents/0105_sets.txt"
)
    rawinput = get_web_input(url)
    map(split(rawinput, '\n', keepempty=false)) do line
        parse.(Int, split(line, ','))
    end
end

function subsets(elems, m, n)
    @assert n >= m
    let elems = copy(elems), VT = Vector{eltype(elems)}
        Channel{VT}() do ch
            v = VT(undef, n)

            function f!(i=1, j=0)
                if i > n
                    put!(ch, copy(v))
                    return
                elseif i > m
                    put!(ch, v[1:i-1])
                end

                for j_next in j+1:length(elems)
                    v[i] = elems[j_next]
                    f!(i + 1, j_next)
                end
            end
            f!()
        end
    end
end

function check_rules(set)
    for subset1 in subsets(set, 1, length(set))
        card1 = length(subset1)
        for subset2 in subsets(setdiff(set, subset1), 1, card1)
            card2 = length(subset2)
            if sum(subset1) == sum(subset2)
                return false
            end
            if card1 > card2 && sum(subset1) <= sum(subset2)
                return false
            end
        end
    end
    return true
end

function solution(input=get_intput())
    sum(sum, filter(check_rules, input))
end

println(solution())
