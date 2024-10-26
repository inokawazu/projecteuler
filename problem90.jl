
const SQUARES = map(1:9) do i
    sqr = i^2
    divrem(sqr, 10)
end

function isdiepair(die1, die2)
    all(SQUARES) do (sq1, sq2)
        hasface(die1, sq1) && hasface(die2, sq2) ||
        hasface(die1, sq2) && hasface(die2, sq1)
    end
end

function hasface(die, n::Integer)
    n in die || (n == 6 && 9 in die) || (n == 9 && 6 in die)
end

# hasface(die, n::Missing) = true

# function count_die_pairs!(die1, die2, n1 = 1, n2 = 1)
#     mis1 = findfirst(ismissing, die1)
#     mis2 = findfirst(ismissing, die2)
# end

# function solution()
#     # println(Set(first.(SQUARES)))
#     # println(Set(last.(SQUARES)))
#     # neededds = union(Set(first.(SQUARES)), Set(last.(SQUARES)))
#     # println(neededds)
#     # println(setdiff(0:9,neededds))
#     # SQUARES

#     @show isdigitpair([0, 5, 6, 7, 8, 9], [1, 2, 3, 4, 8, 9])
#     die1 = Union{Int, Missing}[missing, missing, missing, missing, missing, missing]
#     die2 = Union{Int, Missing}[missing, missing, missing, missing, missing, missing]
#     count_die_pairs(die1, die2)
# end

function dice_arrangements()
    Channel{Vector{Int}}() do ch
        stack = [Int[0]]
        while !isempty(stack)
            next = pop!(stack)

            if length(next) == 6
                push!(ch, copy(next))
                continue
            end

            prev = copy(next)

            if prev[end] < 9
                prev[end] += 1
                push!(stack, prev)
            end

            for i in last(next):9
                push!(stack, [next; i])
            end

        end
    end
end

function solution()
    SQUARES
    # foreach(println, dice_arrangements())
    # ndigits(sum(x->1, dice_arrangements())^2)
    # twodies = Iterators.product(dice_arrangements(), dice_arrangements())
    twodies = ((die1, die2) for die1 in dice_arrangements() for die2 in dice_arrangements())
    # aretwodies = Iterators.map(x->isdiepair(x...), twodies)
    # foreach(println, twodies)
    # count()
    # foreach(println, twodies)
    # count(isdiepair(ds...) for ds in twodies)
    count(twodies) do x
        res = isdiepair(x...)
        if res
            @show x
        end
        return res
    end
end

println(solution())
