ispalindrome(x) = x == reverse(x)

function solution(limit)
    nums = 1:limit-1
    palinums = filter(nums) do n
        ispalindrome(digits(n)) && ispalindrome(digits(n,　base = 2))
    end
    sum(palinums)
end

const LIMIT = 1_000_000
println(solution(LIMIT))
