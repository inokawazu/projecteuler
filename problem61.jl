ngon(n, a, b, c) = n*(n*a + b) ÷ c

tri(n) = ngon(n, 1, 1, 2)
squ(n) = ngon(n, 1, 0, 1)
pen(n) = ngon(n, 3, -1, 2)
hex(n) = ngon(n, 2, -1, 1)
hep(n) = ngon(n, 5, -3, 2)
oct(n) = ngon(n, 3, -2, 1)

function getfourdigs(f)
    nums = Iterators.countfrom(1)
    ngons = Iterators.map(f, nums)
    above = Iterators.dropwhile(<(1000), ngons)
    below = Iterators.takewhile(<=(9000), above)

    validdigpair = Iterators.filter(below) do a
        l, r = divrem(a, 100)
        ndigits(l) == 2 && ndigits(r) == 2
    end

    return collect(validdigpair)
end

function solution()
    ngonfs = [
              tri
              squ
              pen
              hex
              hep
              oct
             ]

    nums = map(getfourdigs, ngonfs)
    sort!(nums, by = length)
    
    inds = 1:length(nums)
    tovisit = map(first(nums)) do n
        ([1], [n])
    end

    while !isempty(tovisit)
        is, ns = pop!(tovisit)

        if length(ns) == length(nums) && last(ns) % 100 == first(ns) ÷ 100
            return sum(ns)
        end

        for i in setdiff(inds, is)
            for nextn in nums[i]
                if last(ns) % 100 == nextn ÷ 100
                    push!(tovisit, ([is; i], [ns; nextn]))
                end
            end
        end
    end
end

println(solution())

# NOT NEEDED BUT kept as a cool thing (which may or may not be broken).
# n == (-b + sqrt(b^2 + 4 a c m))/(2 a)
# 2*a*n + b == sqrt(b^2 + 4 a c m)
# 2*a*n + b == sqrt(k) ∈ ℤ
# 2*a*n + b == sqrt(k) ∈ ℤ
# 2*a*n + b == l ∈ ℤ
# 2*a*n == l - b
# function isngon(m, a, b, c)
#     k = b^2 + 4*a*c*m # if ngon, is a squre number
#     l = isqrt(k)
#     k == l^2 && (l - b) % (2a) == 0
# end

