function count_rect(y, x)
    return sum(Iterators.product(1:y, 1:x)) do (w, z)
        (y - w + 1) * (x - z + 1)
    end
end

function solution(target::T = 2_000_000) where T
    best_dis = typemax(T) - 1
    best_loc = (one(T), one(T))

    for y in Iterators.countfrom(one(target))
        x = y
        while true
            yx_nrecs = count_rect(y, x)

            loc_dis = abs(yx_nrecs - target)
            if loc_dis <= best_dis
                best_loc = (y, x)
                best_dis = loc_dis
            end

            if yx_nrecs > target
                break
            end
            x += 1
        end

        if x == y
            break
        end
    end

    return prod(best_loc)
end

println(solution())
