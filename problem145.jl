function solution(target=9)
    sum(1:target) do n
        (mod(n, 2) == 0 ? 20 * 30^(n ÷ 2 - 1) : zero(target)) +
        (mod(n, 4) == 3 ? 100 * 500^(n ÷ 4) : zero(target))
    end
end

println(solution())
