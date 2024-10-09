function solution(target = 1_500_000)
    ST = Tuple{Int, Int, Int}
    cnts = Dict{Int, Set{ST}}()
    for m in 2:isqrt(target)
        for n in 1:m-1
            a = m^2 - n^2
            b = 2*m*n
            c = m^2 + n^2
            l = a + b + c

            if l > target
                break
            end

            for k in Iterators.countfrom(1)
                if k * l > target
                    break
                end

                if !haskey(cnts, k*l)
                    cnts[k*l] = Set{ST}()
                end

                push!(cnts[k*l], (min(k * a, k * b), max(k * a, k * b), k * c))
            end
        end
    end
    return count(isone∘length, values(cnts))
end

println(solution())
