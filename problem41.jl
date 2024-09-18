include("common.jl")

function solution()
    nums = 99999999:-1:2
    i = findfirst(nums) do n
        isprime(n) && ispandigital(n, ndigits(n))
    end
    return nums[i]
end

println(solution())
