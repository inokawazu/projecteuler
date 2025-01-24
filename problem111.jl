include("common.jl")

function count_repeated(p, d)
    count(==(d), idigits(p))
end

# function M(n, d)
#     ps = Iterators.filter(isprime, (10^(n-1)):(10^n-1))
#     maximum(p -> count_repeated(p, d), ps)
# end

# function N(n, d)
#     ps = Iterators.filter(isprime, (10^(n-1)):(10^n-1))
#     max_count = M(n, d)
#     count(p -> count_repeated(p, d) == max_count, ps)
# end

# function S(n, d)
#     ps = Iterators.filter(isprime, (10^(n-1)):(10^n-1))
#     max_count = M(n, d)
#     sum(Iterators.filter(p -> count_repeated(p, d) == max_count, ps))
# end

# function M(ps, d)
#     # ps = Iterators.filter(isprime, (10^(n-1)):(10^n-1))
#     maximum(p -> count_repeated(p, d), ps)
# end

# function S(ps, d)
#     # ps = Iterators.filter(isprime, (10^(n-1)):(10^n-1))
#     max_count = M(ps, d)
#     sum(Iterators.filter(p -> count_repeated(p, d) == max_count, ps))
# end

# function solution(ndigs = 10)
#     ps = collect(Iterators.filter(isprime, (10^(ndigs-1)):(10^ndigs-1)))
#     @info "Found $(length(ps)) primes"
#     sum(@show(S(ps, d)) for d in 0:9)
# end

# function solution(ndigs = 10)
#     max_ps = Dict(
#                   d => (max_count = Ref(ndigs-1), ps = Int[]) for d in 0:9
#                  )

#     for m in 10^(ndigs-1):10^ndigs-1
#         for d in 0:9
#             dcount = count_repeated(m, d)
#             if max_ps[d].max_count[] > dcount
#                 continue
#             end

#             if !isprime(m)
#                 continue
#             end

#             p = m

#             if max_ps[d].max_count[] < dcount
#                 @info "Updating $d: $(max_ps[d].max_count[]) => $dcount"
#                 empty!(max_ps[d].ps)
#                 max_ps[d].max_count[] = dcount
#             end

#             push!(max_ps[d].ps, p)
#         end
#     end

#     display(max_ps)
#     sum(sum(ps) for (; ps) in values(max_ps))

#     # ps = collect(Iterators.filter(isprime, (10^(ndigs-1)):(10^ndigs-1)))
#     # @info "Found $(length(ps)) primes"
#     # sum(@show(S(ps, d)) for d in 0:9)
# end

function permutations(elems, n)
    let elems = copy(elems), VT = Vector{eltype(elems)}
        Channel{VT}() do ch
            v = VT(undef, n)

            function f!(i=1)
                if i > n
                    put!(ch, copy(v))
                    return
                end

                for elem in setdiff(elems, v[begin:i-1])
                    v[i] = elem
                    f!(i + 1)
                end
            end
            f!()
        end
    end
end

function nrun_numbers(dig, numdigs, run_length)
    run_num_vec = fill(dig, numdigs)

    other_dig_positions = permutations(1:numdigs, numdigs - run_length)

    other_digs = (d for d in 0:9 if d != dig)
    other_dig_combos = Iterators.product((other_digs for _ in 1:numdigs - run_length)...) |> collect

    output = Iterators.map(Iterators.product(other_dig_combos, other_dig_positions)) do (odig_combos, odig_poss)
        for (odig, opos) in zip(odig_combos, odig_poss)
            run_num_vec[opos] = odig
        end
        out = digs2num(run_num_vec)
        run_num_vec .= dig
        out
    end

    output = Iterators.filter(output) do x
        ndigits(x) == numdigs
    end

    return unique(output)
end

function solution(ndigs = 10)
    sum(0:9) do d
        for run_length in ndigs:-1:1
            ps = filter!(isprime, nrun_numbers(d, ndigs, run_length))
            if !isempty(ps)
                return sum(ps)
            end
        end
    end
end

println(solution(10))
