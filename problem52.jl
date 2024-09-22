function solution(maxmult = 6)
    for num in Iterators.countfrom()
        if Iterators.map(1:maxmult) do mult
                sort!(digits(mult * num))
            end |> allequal

            return num
        end
    end
end

println(solution())
