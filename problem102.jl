include("download_input.jl")

using .WebInput

function get_intput(;
    url="https://projecteuler.net/resources/documents/0102_triangles.txt"
)
    rawinput = get_web_input(url)
    map(split(rawinput, '\n', keepempty=false)) do line
        reinterpret(Tuple{Int,Int}, parse.(Int, split(line, ',')))
    end
end

# p1, p2, p3, q
# q = p1 + (p2 - p1) * s + (p3 - p1) * t
function intriangle((qx, qy), ((p1x, p1y), (p2x, p2y), (p3x, p3y)))
    d = p1x*p2y - p1x*p3y - p1y*p2x + p1y*p3x + p2x*p3y - p2y*p3x
    t = p1x*p2y - p1x*qy - p1y*p2x + p1y*qx + p2x*qy - p2y*qx
    s = -p1x*p3y + p1x*qy + p1y*p3x - p1y*qx - p3x*qy + p3y*qx
    return (d > 0 && s > 0 && t > 0 && s + t < d) || 
           (d < 0 && s < 0 && t < 0 && s + t > d)
end

function solution(input = get_intput())
    count(input) do tricoords
        intriangle((0, 0), tricoords)
    end
end

println(solution())
