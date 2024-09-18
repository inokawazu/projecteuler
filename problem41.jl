include("common.jl")

function solution()
    nums = 9999999:-2:2
    i = findfirst(nums) do n
        isprime(n) && ispandigital(n, ndigits(n))
    end
    return nums[i]
end

println(solution())
