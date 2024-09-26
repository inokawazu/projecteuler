include("common.jl")

function next_prime(n)
    return first(Iterators.filter(isprime, Iterators.countfrom(n+1)))
end

function isincreasing(v)
    return all(Iterators.map(<, v, Iterators.drop(v, 1)))
end

# [p1, p2, p3]

function solution(target = 5)
    heulimit = 1_000
    primes = filter(isprime, 3:heulimit)
    primestuples = Iterators.product(ntuple(_->primes, target)...)
    primestuples = Iterators.filter(isincreasing, primestuples)

    for ptuple in primestuples
        isppgroup = all(Iterators.product(ptuple, ptuple)) do (pt1, pt2)
            pt1 == pt2 ||
            isprime(concateprod(pt1, pt2)) &&
            isprime(concateprod(pt2, pt1))
        end
        if isppgroup
            println(ptuple)
            return sum(ptuple)
        end
    end

    # primes = filter(isprime, 1:heulimit)
    # prime_set = Set(primes)

    # ppis = Int[1]
    # while length(ppis) < target
    #     for cand_ppi in ppis[1]:100_000
    #         isrightcat = all(
    #                         ppi->
    #                         concateprod(primes[ppi], primes[cand_ppi])
    #                         in prime_set,
    #                         ppis)
    #         isleftcat = all(
    #                         ppi->
    #                         concateprod(primes[cand_ppi], primes[ppi])
    #                         in prime_set,
    #                         ppis)
    #         if isrightcat && isleftcat
    #             push!(ppis, cand_ppi)
    #             @goto nextwhile
    #         end
    #     end

    #     @label nextwhile
    # end

    # stack = [Int[1]]
    # while !isempty(stack)
    #     ppis = pop!(stack)
    #     for cand_ppi in ppis[1]:100_000
    #         isrightcat = all(
    #                         ppi->
    #                         concateprod(primes[ppi], primes[cand_ppi])
    #                         in prime_set,
    #                         ppis)
    #         isleftcat = all(
    #                         ppi->
    #                         concateprod(primes[cand_ppi], primes[ppi])
    #                         in prime_set,
    #                         ppis)
    #         if isrightcat && isleftcat
    #             push!(ppis, cand_ppi)
    #             break
    #         end
    #     end
    # end

    # starting_primes = Iterators.filter(isprime, Iterators.countfrom(2))
    # starting_primes = Iterators.takewhile(<=(heulimit), starting_primes)

    # for starting_prime in starting_primes
    #     nums = Iterators.countfrom(starting_prime) # starting from nums
    #     primes = Iterators.filter(isprime, nums)
    #     primes = Iterators.takewhile(<=(heulimit), primes)

    #     pair_primes = Int[]
    #     for prime in primes
    #         isrightcat = all(pp->isprime(concateprod(pp, prime)), pair_primes)
    #         isleftcat = all(pp->isprime(concateprod(prime, pp)), pair_primes)
    #         if isrightcat && isleftcat
    #             push!(pair_primes, prime)
    #             println(pair_primes)
    #         end

    #         if length(pair_primes) == target
    #             return sum(pair_primes)
    #         end
    #     end
    # end
end

println(solution(5))
