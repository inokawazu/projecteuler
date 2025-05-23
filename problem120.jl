function solution(target)
    sum(3:target) do a
        rs = Iterators.map(1:a^2) do n
            2 * binomial(n, n % 2) * a^isodd(n) % a^2
        end
        maximum(rs)
    end
end

println(solution(1_000))
