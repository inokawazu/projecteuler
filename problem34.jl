factdigsum(n) = sum(factorial, digits(n))
isfactsum(n) = factdigsum(n) == n

function solution()
    # Note: As 1 and 2 are not sums they are not included.
    nums = Iterators.countfrom(3)
    nums = Iterators.takewhile(<=(9999999), nums)
    factdigs = Iterators.filter(isfactsum, nums)
    return sum(factdigs)
end

println(solution())
