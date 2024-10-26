

# function isdiepair(die1, die2)
#     all(SQUARES) do (sq1, sq2)
#         hasface(die1, sq1) && hasface(die2, sq2) ||
#         hasface(die1, sq2) && hasface(die2, sq1)
#     end
# end

# function hasface(die, n::Integer)
#     n in die || (n == 6 && 9 in die) || (n == 9 && 6 in die)
# end

function make_min_dice((die1, die2), (sqr1, sqr2))
    (
     (union(die1, sqr1), union(die2, sqr2)),
     (union(die1, sqr2), union(die2, sqr1)),
    )
end

function showtrue(x) 
    if x
        println(x)
    end
    x
end

function solution()
    squares = map(1:9) do i
        sqr = i^2
        divrem(sqr, 10)
    end
    # mini_dice = make_minimum_dies()

    mini_dice_pairs = [(Set{Int}(), Set{Int}())]

    for (sqr1, sqr2) in squares
        next_dice_pairs = empty(mini_dice_pairs)

        foreach(mini_dice_pairs) do dice_pair
            append!(next_dice_pairs, make_min_dice(dice_pair, (sqr1, sqr2)))

            if sqr1 == 9
                append!(next_dice_pairs, make_min_dice(dice_pair, (6, sqr2)))
            elseif sqr1 == 6
                append!(next_dice_pairs, make_min_dice(dice_pair, (9, sqr2)))
            end

            if sqr2 == 9
                append!(next_dice_pairs, make_min_dice(dice_pair, (6, sqr1)))
            elseif sqr2 == 6
                append!(next_dice_pairs, make_min_dice(dice_pair, (9, sqr1)))
            end
        end

        mini_dice_pairs = next_dice_pairs

        # add_min_dice!(next_dice, ())
        # map(mini_dice) do (die1, die2)
        #     if !(sqr1 in die1) || !(sqr2 in die2)
        #         if !(sqr1 in die1) && sqr2 in die2
        #         elseif sqr1 in die1 && !(sqr2 in die2)
        #         elseif !(sqr1 in die1) || !(sqr2 in die2)
        #         else
        #             @assert false "Unreachable"
        #         end
        #     end
        #     if !(sqr2 in die1) || !(sqr1 in die2)
        #     end
        # end
    end

    filter!(mini_dice_pairs) do dice
        all(x->length(x) <= 6, dice)
    end

    mini_dice_pairs = map(mini_dice_pairs) do dice
        sort.(collect.(dice))
    end

    reduced_pair_set = empty(mini_dice_pairs)
    for dice_pair in mini_dice_pairs
        parent_ind = findfirst(reduced_pair_set) do reduce_pair
            all(issubset.(dice_pair, reduce_pair))
        end

        if isnothing(parent_ind)
            children_inds = findall(reduced_pair_set) do reduce_pair
                all(issubset.(reduce_pair, dice_pair))
            end
            deleteat!(reduced_pair_set, children_inds)
            push!(reduced_pair_set, dice_pair)
        end
    end

    for i in 1:length(reduced_pair_set)
        for j in i+1:length(reduced_pair_set)
            @assert !all(issubset.(reduced_pair_set[i], reduced_pair_set[j]))
            @assert !all(issubset.(reduced_pair_set[j], reduced_pair_set[i]))
        end
    end

    # foreach(reduced_pair_set) do dice
    #     println(length.(dice))
    # end

    sum(reduced_pair_set) do dice
        10^(12 - sum(length, dice))
    end

    # unique!(mini_dice_pairs)
    # foreach(mini_dice_pairs) do pair
    #     println(pair)
    # end
    # nothing

    # SQUARES
    # # foreach(println, dice_arrangements())
    # # ndigits(sum(x->1, dice_arrangements())^2)
    # # twodies = Iterators.product(dice_arrangements(), dice_arrangements())
    # twodies = ((die1, die2) for die1 in dice_arrangements() for die2 in dice_arrangements())

    # # aretwodies = Iterators.map(x->isdiepair(x...), twodies)
    # # foreach(println, twodies)
    # # count()
    # # foreach(println, twodies)
    # # count(isdiepair(ds...) for ds in twodies)

    # count(twodies) do x
    #     res = isdiepair(x...)
    #     if res
    #         @show x
    #     end
    #     return res
    # end
end

println(solution())
