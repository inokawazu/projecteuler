# 1
# g
#
# 2
# gg
#
# 3
# ggg
# rrr
#
# 4
# gggg
# rrrg
# grrr
# rrrr
#
# 5
# ggggg
# rrrgg
# grrrg
# ggrrr
# rrrrg
# grrrr
# rrrrr

struct Blocks
    len::Int64
    blks::Int64
end

function Blocks(; len)
    Blocks(len, 0)
end

function Base.show(io::IO, blks::Blocks)
    # print(io, "Block (len = $(blks.len)): ")
    print(io, "Block: ")
    for i in 1:length(blks)
        print(io, blks[i] ? 1 : 0)
    end
end

Base.length(blks::Blocks) = blks.len
function Base.getindex(blks::Blocks, i)
    if !(0 < i <= length(blks))
        throw("$i is out of bounds.")
    end
    Bool((blks.blks >> (i - 1)) & 1)
end

function Base.iterate(blks::Blocks, i = 1)
    if i > length(blks)
        return nothing
    end

    return (blks[i], i + 1)
end

function can_add(blks::Blocks, block_pos, block_len)
    block_end = block_pos + block_len - 1
    1 <= block_pos <= length(blks) &&
    1 <= block_end <= length(blks) &&
    (block_pos == 1 || !blks[block_pos - 1]) &&
    (block_end == length(blks) || !blks[block_end + 1]) &&
    all(!blks[i] for i in block_pos:block_end)
end

function add_block(blks::Blocks, block_pos, block_len)
    block_end = block_pos + block_len - 1
    new_blks = blks.blks
    for i in block_pos:block_end
        new_blks |= 1 << (i - 1)
    end
    return Blocks(blks.len, new_blks)
end

function fun_solution(len)
    tovisit = [Blocks(len = len)]
    visited = Set{eltype(tovisit)}()
    push!(visited, tovisit[1])

    while !isempty(tovisit)
        blks = pop!(tovisit)
        # sleep(1)
        # println(blks)
        for addlen in 3:len
            for addpos in 1:(len - addlen + 1)
                can_add(blks, addpos, addlen) || continue
                nextblk = add_block(blks, addpos, addlen)
                if !in!(nextblk, visited)
                    push!(tovisit, nextblk)
                # else
                #     println("Found Duplicate: ", nextblk)
                end
            end
        end
    end

    length(visited)
end

function solution(len)
    n = len + 1
    return sum(binomial(n-2k, 2k) for k in 0:fld(n, 4))
end

println(solution(50))
