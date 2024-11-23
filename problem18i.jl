using Nemo
include("common.jl")

function getprimes(lb, hb)
    nums = lb:hb
    num_groups = Iterators.partition(nums, length(nums) ÷ Threads.nthreads())
    tsks = map(num_groups) do tnums
        Threads.@spawn(filter(isprime, tnums))
    end
    sort!(mapreduce(fetch, vcat, tsks))
end

f(x) = x^3 - 3x + 4

function R(p::T) where T
    K = GF(p)
    _, x = K["x"]
    fx = f(x)

    if !is_irreducible(fx)
        return zero(p)
    end

    _, y = finite_field(fx, "y")

    alpha = y
    beta = alpha^p
    gamma = beta^p

    Rp = -(gamma ^ p - gamma) * (alpha ^ p - alpha) * (beta ^ p - beta)

    return T(lift(ZZ, coeff(Rp, 0)))
end

# The correct answer 842507000531275
# test R's for cases where f(x) is irreducible.
# (* (109, 60) *)
# (* (113, 44) *)
# (* (137, 19) *)
# (* (149, 47) *)
# (* (157, 33) *)
# (* (173, 117) *)

function solution(limits=(1_000_000_000, 1_100_000_000))
    primes = getprimes(limits...)

    nps = length(primes)
    @info "Found $nps primes. R computtation to take $(0.0002 * nps) seconds"
    
    return sum(Iterators.partition(primes, length(primes) ÷ Threads.nthreads())) do ps
        sum(R, ps)
    end
end

println(solution())
