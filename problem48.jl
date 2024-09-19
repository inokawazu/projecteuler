function solution(target = 1000)
    return sum(1:target) do n
        powermod(n, n, 10^10)
    end % 10^10
end

println(solution())
