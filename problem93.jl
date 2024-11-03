function digitsets(target_len=4)
    return Channel{Vector{Int}}() do ch
        v = Int[]
        function f!()
            if length(v) == target_len
                put!(ch, copy(v))
                return nothing
            end

            previ = isempty(v) ? -1 : v[end]
            for i in previ+1:9
                push!(v, i)
                f!()
                pop!(v)
            end
            return nothing
        end

        f!()
    end
end

function permutations(noutof)
    return Channel{Vector{Int}}() do ch
        v = Int[]
        function f!()
            if length(v) == noutof
                put!(ch, copy(v))
                return nothing
            end

            for i in setdiff(1:noutof, v)
                push!(v, i)
                f!()
                pop!(v)
            end
            return nothing
        end

        f!()
    end
end

function combinations(choose, noutof)
    return Channel{Vector{Int}}() do ch
        v = Int[]
        function f!()
            if length(v) == choose
                put!(ch, copy(v))
                return nothing
            end

            for i in 1:noutof
                push!(v, i)
                f!()
                pop!(v)
            end
            return nothing
        end

        f!()
    end
end

function longest_streak(v)
    v = sort(unique(v))
    l = 0
    for (n, elem) in zip(Iterators.countfrom(1), v)
        if n == elem
            l += 1
        else
            break
        end
    end

    return l
end

function solution(ndigits=4)
    opcombos = collect(combinations(ndigits - 1, 4))
    avail_ops = (+, -, *, /)
    num_orders = collect(permutations(ndigits))

    maxdigitset = zeros(Rational{Int}, ndigits)
    maxdigitlen = 0

    for digitset in digitsets(ndigits)
        digitset = Rational.(digitset)

        opords = Iterators.product(opcombos, num_orders)
        pos_nums = Iterators.map(opords) do (opcombo, num_order)
            out = digitset[num_order[begin]]
            rest = digitset[num_order[begin+1:end]]

            for (opcode, operand) in zip(opcombo, rest)
                try
                    out = (avail_ops[opcode])(out, operand)
                catch e
                    # e isa ArgumentError && return 1 // 0
                    e isa DivideError && return 1 // 0
                    rethrow()
                end
            end
            out
        end

        valid_ints = Iterators.filter(isinteger,
            Iterators.filter(>(0),
                Iterators.filter(isfinite, pos_nums)))

        run_len = longest_streak(valid_ints)
        # @show join(Int.(digitset)), run_len
        # println(sort(unique(valid_ints)))
        if run_len > maxdigitlen
            maxdigitlen = run_len
            maxdigitset = digitset
        # elseif run_len == maxdigitlen 
        #     @warn "Found equality" digits=join(Int.(digitset))
        end
    end
    @show maxdigitlen
    return join(Int.(maxdigitset))
end

println(solution())

# foreach(println, digitsets())
# foreach(println, permutations(4))
# foreach(println, combinations(3, 4))
# println(reinterpret(reshape, Int, collect(digitsets())))
# display(stack(digitsets(), dims = 1))
