include("common.jl")

function nsqrdivs(nfactors)
    prod(2a+1 for a in nfactors)
end

function numberofsols(factors)
    (nsqrdivs(factors)+1)÷2
end

function findn(primes, pfactors)
    T = eltype(primes)
    prod((p ^ a for (p, a) in zip(primes, pfactors)), init = one(T))
end


function findlogn(primes, pfactors)
    T = eltype(primes)
    sum((a * log10(p) for (p, a) in zip(primes, pfactors)), init = zero(T))
end

lowerboundn(target) = 2 ^ cld(target - 1, 2)
function lowerboundlogn(target, primes)
    as = [(float(target) ^ (1/m) - 1)/2 for m in 1:length(primes)]
    minimum(1:length(primes)) do n
        findlogn(primes[1:n], as[1:n])
    end
end

# function findminn(
#         primes, target, 
#         nbest = lowerboundn(target), 
#         state = zeros(Int, length(primes))
#     )
#     n = findn(primes, state)

#     if n > nbest
#         return nbest
#     elseif nsqrdivs(state) > target
#         @info "Found solution!" n=n
#         return n
#     end

#     for i in eachindex(state)
#         state[i] += 1

#         ncand = findminn(primes, target, nbest, state)
#         nbest = min(ncand, nbest)

#         state[i] -= 1
#     end

#     return nbest
# end

function solution(target, nprimes = 12)
    primes = Iterators.take(Iterators.filter(isprime, Iterators.countfrom(2one(target))), nprimes) |> collect

    factors = zero.(primes)
    minn = Ref(typemax(target)÷100)
    @show minn[]

    reverse!(primes)

    function findminn(i = 1)
        if findn(primes, factors) >= minn[]
            return false
        elseif numberofsols(factors) > target
            minn[] = findn(primes, factors)
            @info "found sol" n_ndigits = ndigits(findn(primes, factors)) n=findn(primes, factors)
            return true
        elseif i > length(primes)
            return false
        end

        for jfact in Iterators.countfrom(zero(target))
            factors[i] = jfact
            findminn(i + 1)
            if findn(primes, factors) > minn[]
                break
            end
        end
        factors[i] = 0
        return true
    end

    # function findminn(x)
    #     (ithp, minn) = x
    #     nsols = numberofsols(factors)
    #     n = findn(primes, factors)

    #     if nsols > target && n < minn
    #         @info "found sol" n = n
    #         return nsols, n 
    #     end

    #     if ithp > length(primes)
    #         return nothing
    #     end

    #     if n >= minn
    #         return nothing
    #     end

    #     for jfact in Iterators.countfrom(zero(target))
    #         factors[ithp] = jfact

    #         cand_x = findminn((ithp + 1, n))

    #         # if !isnothing(n) && !isnothing(cand_n) && cand_n >= n
    #         #     break
    #         # end
    #         # n = cand_n
    #     end
    #     factors[ithp] = 0

    #     return n
    # end

    findminn()
    return minn[]
end

# function solution(target, nprimes = 12)
#     primes = Iterators.take(Iterators.filter(isprime, Iterators.countfrom(2one(target))), nprimes) |> collect

#     stack = [zero(target)]
#     factors = zero.(primes)
#     beststate = zero.(primes)
#     @show lognbest = lowerboundlogn(target, primes)

#     while !isempty(stack)
#         println(numberofsols(factors))
#         # @show length(stack)
#         # if length(stack) > 10000
#         #     println(factors)
#         #     println(findlogn(primes, factors))
#         #     return 123
#         # end
#         i = pop!(stack)

#         if i == 0
#             logn = findlogn(primes, factors)
#             if logn >= lognbest
#                 continue
#             elseif numberofsols(factors) > target
#                 lognbest = logn
#                 beststate .= factors
#                 if lognbest < 80
#                     @info "Found best" stacksize = length(stack) n = findn(big.(primes), beststate)
#                 end
#                 continue
#             end

#             factors[i + 1] += 1
#             push!(stack, i + 1)
#             push!(stack, 0)
#         elseif 1 <= i <= length(factors)
#             factors[i] -= 1

#             if i < length(factors)
#                 factors[i + 1] += 1
#                 push!(stack, i + 1)
#                 push!(stack, 0)
#             end
#         end
#     end

#     return findn(big.(primes), beststate)
# end


# function pfactors(n::T) where T <: Integer
#     divs = Dict{T, T}()
#     maxi = isqrt(n)

#     for i in Iterators.countfrom(2one(T))
#         while mod(n, i) == 0
#             n ÷= i
#             divs[i] = get(divs, i, zero(T)) + 1
#         end

#         if isone(n)
#             break
#         elseif i == maxi
#             divs[n] = get(divs, n, zero(T)) + 1
#             n ÷= n
#             break
#         end
#     end
#     return divs
# end

# countsqrdivs(n) = prod(Iterators.map(x -> 2x+1, values(pfactors(n))), init = one(n))

# function countsqrdivs2(n::Integer)
#     cnt = one(n)
#     for i in 2:isqrt(n)
#         acnt = zero(i)
#         while mod(n, i) == 0
#             n ÷= i
#             acnt += 1
#         end
#         cnt *= 2acnt + 1
#     end
#     if !isone(n)
#         cnt *= 2*1+1
#     end
#     return cnt
# end

# # Main function
# function solution(target::T) where T
#     for i in 1:100
#         @assert countsqrdivs(i) == countsqrdivs2(i)
#     end

#     println(@.((countsqrdivs2(1:100)+1)÷2))

#     for n in Iterators.countfrom(one(T))
#         if mod(n, 10^6) == 0
#             @show n
#         end
#         if (countsqrdivs2(n)+1)÷2 > target
#             return n - 1
#         end
#     end
# end

# print(solution(4*10^6))
