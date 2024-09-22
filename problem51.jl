include("common.jl")


function _replace_permutations(nrep::T, nmax, ch, cur = T[]) where T
    if nrep <= 0 || nmax <= 0
        put!(ch, copy(cur))
        return
    end

    for a in nrep:nmax
        _replace_permutations(nrep - 1, a - 1, ch, [cur; a])
    end

end

function replace_permutations(nrep::T, nmax) where T
    ch = Channel{Vector{T}}(0, spawn=false) do c
        _replace_permutations(nrep, nmax, c)
    end
    return ch
end

function replacedigits(n, repinds, repdigit)
    digs = digits(n)
    digs[repinds] .= repdigit
    return digs2num(digs)
end

function solution(target = 6)
    nums = Iterators.countfrom()
    primes = Iterators.filter(isprime, nums)

    for prime in primes
        nmax = ndigits(prime)
        for nrep in 1:nmax
            for repinds in replace_permutations(nrep, nmax)
                if !allequal(digits(prime)[repinds])
                    continue
                end

                famsize = count(0:9) do repdigit
                    replaced = replacedigits(prime, repinds, repdigit)
                    isprime(replaced) && ndigits(replaced) == ndigits(prime)
                end

                if famsize >= target
                    return prime
                end
            end
        end
    end
end
