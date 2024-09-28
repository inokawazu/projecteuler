include("common.jl")

function find_prime_pairs(n::T) where T
    output = Tuple{T, T}[]
    for id in 1:ndigits(n)-1
        num1, num2 = divrem(n, 10^id)
        ldnum2 = div(num2, 10^(id-1))
        if !iszero(ldnum2) && all(isprime, (num1, num2))
            push!(output, (num1, num2))
        end
    end

    return output
end

function is_prime_pair(n::T) where T
    for id in 1:ndigits(n)-1
        num1, num2 = divrem(n, 10^id)
        ldnum2 = div(num2, 10^(id-1))
        if !iszero(ldnum2) && all(isprime, (num1, num2))
            return true
        end
    end

    return false
end

function solution(target::T = 5) where T
    nums = Iterators.countfrom(one(T))
    nums = Iterators.take(nums, 100_000_000)

    pp_primes = Set(Iterators.filter(x->is_prime_pair(x) && isprime(x), nums))

    primes = Iterators.filter(isprime, nums)
    search_primes = collect(Iterators.take(primes, 10_000))
    target -= 1
    output = Set.(search_primes)

    while target > 0
        cats = Iterators.filter(Iterators.product(search_primes, output)) do (prime, pp_set)
            !(prime in pp_set) && 
            all(pp -> concateprod(prime, pp) in pp_primes && concateprod(pp, prime) in pp_primes, pp_set)
        end

        new_pp_sets = Iterators.map(cats) do (prime, pp_set)
            union(pp_set, prime)
        end

        output = unique(new_pp_sets)

        target -= 1
    end

    return minimum(sum, output)
end

println(solution())
