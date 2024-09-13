# instances

const LATTICE_PATHS_MEMO = Dict{Tuple{Int64, Int64}, Int64}()
function lattice_paths((n, m))
    # memo
    if (n, m) in keys(LATTICE_PATHS_MEMO)
        return LATTICE_PATHS_MEMO[(n, m)]
    end

    # base case
    if n == m == 0
        LATTICE_PATHS_MEMO[(n, m)] = 1
        return 1
    end

    # recurse 
    output = 0
    if n > 0
        output += lattice_paths((n-1, m))
    end
    if m > 0
        output += lattice_paths((n, m-1))
    end

    LATTICE_PATHS_MEMO[(n, m)] = output
    return output
end

function solution(n)
    return lattice_paths((n, n))
end

const INPUT = 20
println(solution(INPUT))
