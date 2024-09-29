function solution()
    T = UInt128
    solnums = Set{T}()
    foreach(Iterators.product(T(1):T(21), T(1):T(10))) do (n, b)
        x = b^n
        if ndigits(x) == n
            push!(solnums, x)
        end
    end
    return length(solnums)
end

println(solution())
