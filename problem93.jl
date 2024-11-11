function permutations(elems, n)
    let elems = copy(elems), VT = Vector{eltype(elems)}
        Channel{VT}() do ch
            v = VT(undef, n)

            function f!(i=1)
                if i > n # all(!=(NotFilled(), v))
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

function longest_streak(v)
    @assert eltype(v) <: Integer
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

function solution()
    digitss = ((a, b, c, d)
              for a in 0+1:9
              for b in a+1:9
              for c in b+1:9
              for d in c+1:9) |> collect
    opss = Iterators.product(
                             [(+), (-), (*), (/)],
                             [(+), (-), (*), (/)],
                             [(+), (-), (*), (/)],
                            ) |> collect
    oprands_posss = collect(permutations([1,2,3,4], 4))

    @assert length(digitss) == 126
    @assert length(opss) == 4^3

    (join∘argmax)(digitss) do digits
        nums = Iterators.flatmap(Iterators.product(opss, oprands_posss)) do (ops, poss)
            x = Rational.(digits[poss])
            (
             ops[2](ops[1](x[1], x[2]), ops[3](x[3], x[4])),
             ops[3](ops[2](ops[1](x[1], x[2]), x[3]), x[4])
            )
        end

        pinums = map(Int, Iterators.filter(nums) do n
            !isnothing(n) && isinteger(n) && n > 0
        end)
        longest_streak(pinums)
    end
end

println(solution())
