include("download_input.jl")

using .WebInput

# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace
struct Card{R, S}
    rank::R
    suit::S
end

rank(c::Card) = c.rank
suit(c::Card) = c.suit

function strrank(c::Card)
    if rank(c) < 10
        return string(rank(c))
    elseif rank(c) == 10
        return "T"
    elseif rank(c) == 11
        return "J"
    elseif rank(c) == 12
        return "Q"
    elseif rank(c) == 13
        return "K"
    elseif rank(c) == 14
        return "A"
    else
        @assert false "unreachable, rank = $(rank(c))"
    end
end
Base.show(io::IO, c::Card) = show(io, "$(strrank(c))$(suit(c))")

function Base.parse(_::Type{Card{Int, Char}}, s::AbstractString)
    @assert length(s) == 2
    rank = if isdigit(s[1])
        parse(Int, s[1])
    elseif s[1] == 'T'
        10
    elseif s[1] == 'J'
        11
    elseif s[1] == 'Q'
        12
    elseif s[1] == 'K'
        13
    elseif s[1] == 'A'
        14
    else
        @assert false "unreachable, rank = $(s[1])"
    end

    @assert s[2] in "CHDS"
    suit = s[2]
    return Card{Int, Char}(rank, suit)
end

function parse_raw_input(raw_input)
    map(split(raw_input, '\n', keepempty=false)) do line
        parse.(Card{Int, Char}, split(line, keepempty=false))
    end
end

combineresults(x, y) = (x[1] && y[1], x[2])

isroyalflush(hand) = combineresults(isflush(hand), (issetequal(rank.(hand), 10:14), 14))

function isstraightflush(hand)
    return combineresults(isflush(hand), isstraight(hand))
end

function isnkind(hand, n)
    isn = false
    val = minimum(rank, hand)
    for r in unique(rank(c) for c in hand)
        if count(c->rank(c)==r, hand) == n
            isn = true
            val = max(r, val)
        end
    end

    return isn, val
end

function isfullhouse(hand)
    combineresults(
                   isnkind(hand, 3),
                   isnkind(hand, 2)
                  )
end

isflush(hand) = (allequal(suit(c) for c in hand), maximum(rank, hand))

function isstraight(hand)
    minrank = minimum(rank(c) for c in hand)
    return (
            issetequal(rank.(hand), minrank:minrank+4),
            minrank+4
           )
end

function istwopairs(hand)
    npairs = 0
    val = 0

    for r in unique(rank(c) for c in hand)
        if count(c->rank(c)==r, hand) == 2
            npairs += 1
            val = max(val, r)
        end

        if npairs == 2
            return true, val
        end
    end

    return false, val
end

ishighcard(hand) = true, maximum(rank, hand)
isfourkind(hand) = isnkind(hand, 4)
isthreekind(hand) = isnkind(hand, 3)
ispair(hand) = isnkind(hand, 2)

function player1win(hand1, hand2)
    checkfs = [
               isroyalflush
               isstraightflush
               isfourkind
               isfullhouse
               isflush
               isstraight
               isthreekind
               istwopairs
               ispair
               ishighcard
              ]
    for checkf in checkfs
        cfh1, tbval1 = checkf(hand1)
        cfh2, tbval2 = checkf(hand2)
        if xor(cfh1, cfh2)
            return cfh1
        elseif cfh1 && cfh2 && tbval1 != tbval2
            return tbval1 > tbval2
        end
    end
    @assert false "unreachable"
end

getinput() = parse_raw_input(get_web_input("https://projecteuler.net/resources/documents/0054_poker.txt"))

function solution(plays = getinput())
    count(plays) do play
        player1 = play[1:5]
        player2 = play[6:10]
        player1win(player1, player2)
    end
end

println(solution())
