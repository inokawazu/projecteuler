include("common.jl")

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
