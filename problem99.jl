include("download_input.jl")

using .WebInput

function get_intput(;
    url="https://projecteuler.net/resources/documents/0099_base_exp.txt"
)
    rawinput = get_web_input(url)
    map(split(rawinput, "\n", keepempty=false)) do line
        parse.(Int, split(line, ','))
    end
end

function baseexplog((b, e))
    return e * log(b)
end

function solution(input=get_intput())
    argmax(eachindex(IndexLinear(), input)) do i
        baseexplog(input[i])
    end
end

println(solution())
