# 6
# 5 1 => 1
# 4 2 => 2
# 3 3 => 3
# 2 2 2 => 3
# 2 2 1 1
# 2 1 1 1 1
# 1 1 1 1 1 1 => 1
#
# 4
# 
# 3 1
# 2 2
# 2 1 1
# 1 1 1 1
#
# 5
#
# 4 1
# 3 2
# 3 1 1
# 2 2 1
# 2 1 1 1
# 1 1 1 1 1
#
# 2
# 1 1
#

function solution(target::T = 100) where T
    tablu = zeros(T, target + 1, target)
    tablu[1, :] .= 1

    for build in 2:target+1
        for limit in 1:target
            tablu[build, limit] = sum(1:min(limit, build - 1)) do n
                tablu[build - n, n]
            end
        end
    end

    return tablu[end, end-1]
end

println(solution(100))
