include("common.jl")

function ispermutation(n::Integer, m::Integer)
    return ndigits(n) == ndigits(m) && sort(digits(n)) == sort(digits(m))
end

function solution(target = 10_000_000)
    nums = 2:target-1

    tots = Iterators.filter(nums) do n
        ispermutation(n, totient(n))
    end

    argmin(n->n/totient(n), tots)
end

println(solution())
