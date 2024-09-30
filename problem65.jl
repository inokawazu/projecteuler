include("common.jl")

function e_a(m::T) where T
    if iszero(m)
        return 2one(T)
    end

    # m + 1 = 3 -×2/3> 2 = 2n
    #         6 -×2/3> 4
    #         9 -×2/3> 6
    return (m + 1) % 3 == 0 ? 2 * (m + 1) ÷ 3 : one(T)
end

function solution(target::T = big"100") where T
    econv = Iterators.drop(continued_fraction_convergents(e_a, T), target-1)
    nth_conv = first(econv)
    return sum(digits(numerator(nth_conv)))
end

println(solution())
