function solution(target = 12_000, left = 1//3, right = 1//2)
    fracs = Set(n//d for d in 1:target for n in 1:d-1 if left < n//d < right)
    return length(fracs)
end

println(solution())
