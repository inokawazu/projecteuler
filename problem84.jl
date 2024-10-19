using Random

struct NextRailWay end
struct NextUtility end
struct BackThree end
struct NoMovement end

const NSQUARES = 40

const GO = 0
const A1 = 1
const CC1 = 2
const A2 = 3
const T1 = 4
const R1 = 5
const B1 = 6
const CH1 = 7
const B2 = 8
const B3 = 9
const JAIL = 10
const C1 = 11
const U1 = 12
const C2 = 13
const C3 = 14
const R2 = 15
const D1 = 16
const CC2 = 17
const D2 = 18
const D3 = 19
const FP = 20
const E1 = 21
const CH2 = 22
const E2 = 23
const E3 = 24
const R3 = 25
const F1 = 26
const F2 = 27
const U2 = 28
const F3 = 29
const G2J = 30
const G1 = 31
const G2 = 32
const CC3 = 33
const G3 = 34
const R4 = 35
const CH3 = 36
const H1 = 37
const T2 = 38
const H2 = 39


const CH_POS = (CH1, CH2, CH3)
const CH_CARDS = [
                  GO, JAIL, C1, E3, 
                  H2, R1, NextRailWay(), NextRailWay(), 
                  NextUtility(), BackThree(), NoMovement(), NoMovement(),
                  NoMovement(), NoMovement(), NoMovement(), NoMovement(),
                 ]

const CC_POS = (CC1, CC2, CC3)
const CC_CARDS = [
                  GO, JAIL, NoMovement(), NoMovement(),
                  NoMovement(), NoMovement(), NoMovement(), NoMovement(),
                  NoMovement(), NoMovement(), NoMovement(), NoMovement(),
                  NoMovement(), NoMovement(), NoMovement(), NoMovement(),
                 ]

const JAIL_DOUBLES = 3

mutable struct Player{I<: Integer} 
    position::I
    inrow::I
end

function advance!(player::Player, n)
    player.position = mod(player.position + n, NSQUARES)
    return player
end

function draw!(cards)
    drawn = popfirst!(cards)
    push!(cards, drawn)
    return drawn
end


function move!(player::Player, _::NextRailWay)
    while !(advance!(player, 1).position in (R1, R2, R3, R4)) end
    return player
end

function move!(player::Player, _::NextUtility)
    while !(advance!(player, 1).position in (U1, U2)) end
    return player
end

move!(player::Player, _::NoMovement) = player

function move!(player::Player, _::BackThree)
    advance!(player, -3)

    # could be needed
    # if player.position == G2J
    #     move!(player, G2J)
    # end

    return player
end

function move!(player::Player, pos::Integer)
    player.position = pos
    return player
end

card_move(player::Player, _::NoMovement) = player

function play_turn!(player, ch_cards, cc_cards, nsides)
    # per turn
    # roll dice
    die1 = rand(1:nsides)
    die2 = rand(1:nsides)
    # check doubles
    if die1 == die2
        player.inrow += 1
    else
        player.inrow = 0
    end

    # @show player.inrow
    @assert 0 <= player.inrow <= 3

    # 3 doubles to jail?
    if player.inrow >= JAIL_DOUBLES
        player.inrow = 0
        player.position = JAIL
        return player
    end

    advance!(player, die1 + die2)

    if player.position in CH_POS
        move!(player, draw!(ch_cards))
    elseif player.position in CC_POS
        move!(player, draw!(cc_cards))
    elseif player.position == G2J
        move!(player, JAIL)
    end
end

function solution(nsides = 4)
    nturns = 10000
    ngames = 1000

    tally = Dict(i => 0 for i in 0:NSQUARES-1)

    for _ in 1:ngames
        # per game start
        cc_cards = shuffle(CC_CARDS)
        ch_cards = shuffle(CH_CARDS)
        player = Player(0, 0)

        for _ in 1:nturns
            play_turn!(player, ch_cards, cc_cards, nsides)
            tally[player.position] += 1
        end
    end

    res = sort!(
                [pos => times/nturns/ngames for (pos, times) in tally],
                by = last,
                rev = true
               )

    display(res)
    join((string).(first.(res[1:3]), pad=2))
end



# struct Player{I<: Integer} 
#     position::I
#     inrow::I
# end

# Player(pos::T = 0, inrow = zero(pos)) where T = Player{T}(pos, inrow)

# function draw!(cards)
#     drawn = popfirst!(cards)
#     push!(cards, drawn)
#     return drawn
# end

# card_move(player::Player, pos::Integer) = Player(pos, pos != JAIL ? player.inrow : 0)

# function card_move(player::Player, _::NextRailWay)
#     ppos = mod(player.position + 1, NSQUARES)
#     while !(ppos in (R1, R2, R3, R4))
#         ppos = mod(ppos + 1, NSQUARES)
#     end
#     return Player(ppos, player.inrow)
# end

# function card_move(player::Player, _::NextUtility)
#     ppos = mod(player.position + 1, NSQUARES)
#     while !(ppos in (U1, U2))
#         ppos = mod(ppos + 1, NSQUARES)
#     end
#     return Player(ppos, player.inrow)
# end

# function card_move(player::Player, _::BackThree)
#     newpos = mod(player.position - 3, NSQUARES)
#     if newpos == G2J
#         Player(JAIL, 0)
#     else
#         Player(newpos, player.inrow)
#     end
# end

# card_move(player::Player, _::NoMovement) = player

# function dice_move(player::Player, nsides, ch_cards, cc_cards)
#     @assert nsides > 0

#     die1 = rand(1:nsides)
#     die2 = rand(1:nsides)
    
#     inrow = die1 == die2 ? player.inrow + 1 : 0

#     newpos = mod(player.position + die1 + die2, NSQUARES)

#     if inrow >= 3
#         Player(JAIL, 0)
#     elseif newpos in CH_POS
#         card = draw!(ch_cards)
#         card_move(player, card)
#     elseif newpos in CC_POS
#         card = draw!(cc_cards)
#         card_move(player, card)
#     elseif newpos == G2J
#         card_move(player, G2J)
#     else
#         Player(newpos, inrow)
#     end
# end

# function solution(nsides = 4)
#     nmoves = 1000
#     nsims = 1000

#     ch_cards = copy(CH_CARDS)
#     cc_cards = copy(CC_CARDS)
#     tally = Dict(i => 0 for i in 0:NSQUARES-1)
#     for _ in 1:nsims
#         player = Player()
#         shuffle!(ch_cards)
#         shuffle!(cc_cards)
#         for _ in 1:nmoves
#             player = dice_move(player, nsides, ch_cards, cc_cards)
#             tally[player.position] += 1
#         end
#     end

#     # future_tallies = map(1:nsims) do _
#     #     ch_cards = copy(CH_CARDS)
#     #     cc_cards = copy(CC_CARDS)

#     #     Threads.@spawn begin 
#     #         sim_tally = Dict(i => 0 for i in 0:NSQUARES-1)
#     #         player = Player()
#     #         shuffle!(ch_cards)
#     #         shuffle!(cc_cards)
#     #         for _ in 1:nmoves
#     #             player = dice_move(player, nsides, ch_cards, cc_cards)
#     #             sim_tally[player.position] += 1
#     #         end
#     #         sim_tally
#     #     end
#     # end
#     # tally = mapreduce(fetch, mergewith(+), future_tallies)

#     res = sort!(
#                 [pos => times/nmoves/nsims for (pos, times) in tally],
#                 by = last,
#                 rev = true
#                )

#     display(res)
#     join((string).(first.(res[1:3]), pad=2))
# end

println(solution())
