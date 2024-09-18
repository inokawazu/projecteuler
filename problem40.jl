function solution(limit = 6)
    ccdigs = Iterators.flatmap(Iterators.reverse∘digits, Iterators.countfrom(1))
    prod(10^ne for ne in 0:limit) do n
        first(Iterators.drop(ccdigs, n-1))
    end
end

println(solution())
