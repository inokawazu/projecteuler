using Downloads

function get_input()
    url = "https://projecteuler.net/resources/documents/0067_triangle.txt"
    triangleio = IOBuffer()
    Downloads.download(url, triangleio)
    return String(take!(triangleio))
end

function parse_input(input)
    lines = split(strip(input), "\n")
    return map(lines) do line
        parse.(Int, split(line))
    end
end

function solution(triangle)
    current = [zero(triangle[end]); 0]
    for row in reverse(triangle)
        @assert length(row) + 1 == length(current)
        current = map(row, current, Iterators.drop(current, 1)) do r, cn, cnp1
            r + max(cn, cnp1)
        end
    end
    @assert 0 + 1 == length(current)
    return first(current)
end

println(solution(parse_input(get_input())))
