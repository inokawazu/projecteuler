# 0 < a <= b,  c
# dis left
# sqrt(x^2 + b^2) + sqrt((x - a)^2 + c^2)
# dis right
# sqrt(x^2 + a^2) + sqrt((x - b)^2 + c^2)
# min left dis 
# sqrt(1 + a^2/(b ± c)^2) * (b + c)
# min right dis 
# sqrt(1 + b^2/(a ± c)^2) * (a + c)

# min left dis squared
# ( 1 + a^2/(b ± c)^2 ) * (b + c)^2
# min left right squared
# (1 + b^2/(a ± c)^2) * (a + c)^2

function solution(target::T = 1_000_000) where T
    # for M in Iterators.countfrom(one(T))
    #     mcount = 0
    #     for b in 2:2:M
    #         for a in 1:b
    #             for c in M
    #                 x = 
    #                 sqrt((b÷2)^2 + a^2) + sqrt((b÷2)^2 + c^2)
    #                 # disqr = a^2 + b^2÷2 + c^2
    #                 # if isqrt(disqr)^2 == disqr
    #                 # end
    #             end
    #         end
    #     end
    #     # count(Iterators.product(1:M, 2:2:M, 1:M)) do abc
    #     # end
    # end
end

println(solution(2000))
