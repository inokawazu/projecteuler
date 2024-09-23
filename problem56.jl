function solution(lower= 90, limit = 100)
    maximum(sum(digits(big(a)^b)) for a in lower:limit-1 for b in lower:limit-1)
end

println(@time solution())
