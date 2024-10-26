function snflip(n)
    if n == 9
        6
    elseif n == 6
        9
    else
        n
    end
end

function hasdiceface(die, face)
    face in die || snflip(face) in die
end

function ischildof(pair1, pair2)
    mapreduce(issubset, (x,y) -> x && y, pair1, pair2)
end

function arerelated(pair1, pair2)
    ischildof(pair1, pair2) || ischildof(pair2, pair1)
end

function solution()
    squares = map(1:9) do i
        sqr = i^2
        divrem(sqr, 10)
    end

    # (die1, die2, level)
    queue = [
             (Set{Int}(), Set{Int}(), 0)
            ]

    pairs = Tuple{Set{Int}, Set{Int}}[]

    while !isempty(queue)
        die1, die2, level = popfirst!(queue)

        if level == length(squares)
            # any(pairs) do pair
            #     ischildof((die1, die2), pair)
            # end && continue

            # child_inds = findall(pairs) do pair
            #     ischildof(pair, (die1, die2))
            # end
            # deleteat!(pairs, child_inds)
            push!(pairs, (die1, die2))

            continue
        end

        next_level = level + 1
        (sqr1, sqr2) = squares[next_level]
        @show squares[next_level]

        # dies = union(die1, die2)
        if (hasdiceface(die1, sqr1) && hasdiceface(die2, sqr2)) || 
            (hasdiceface(die1, sqr2) && hasdiceface(die2, sqr1))
            push!(queue, (die1, die2, next_level))
        elseif (!hasdiceface(die1, sqr1) && hasdiceface(die2, sqr2)) || 
            (hasdiceface(die1, sqr2) && !hasdiceface(die2, sqr1))
            # add sqr1
            hasdiceface(die2, sqr2) && push!(queue, (union(die1, sqr1), die2, next_level))
            hasdiceface(die1, sqr2) && push!(queue, (die1, union(die2, sqr1), next_level))
        elseif (hasdiceface(die1, sqr1) && !hasdiceface(die2, sqr2)) || 
            (!hasdiceface(die1, sqr2) && hasdiceface(die2, sqr1))
            # add sqr2
            hasdiceface(die2, sqr1) && push!(queue, (union(die1, sqr2), die2, next_level))
            hasdiceface(die1, sqr1) && push!(queue, (die1, union(die2, sqr2), next_level))
        else 
            # add sqr2 and sqr1
            push!(queue, (union(die1, sqr1), union(die2, sqr2), next_level))
            push!(queue, (union(die1, sqr2), union(die2, sqr1), next_level))
        end
    end

    # foreach(println,pairs)
    # pairs

    sum(pairs, init = 0) do (die1, die2)
        n69s = count(x->x in (6, 9), die1) + count(x->x in (6, 9), die2)
        ndigs = sum(length, (die1, die2))
        2^n69s * binomial(10 + (12 - ndigs) - 1, (12 - ndigs))# 10^(12 - ndigs)
    end
end

println(solution())
