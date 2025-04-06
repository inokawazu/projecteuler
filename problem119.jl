include("common.jl")

function mink(nd::T) where {T <: Integer}
    nines = sum(9 * 10^n for n in 0:nd-1)
    floor(T, log(nines)/log(9 * nd))
end

function maxk(nd::T) where {T <: Integer}
    ceil(T, log(2 * 10^(nd-1))/log(2))
end

function solution(n::T) where T
    found = zero(T)
    for nd in Iterators.countfrom(2one(T))
        for sumdigs in 2:9*nd
            for k in mink(nd):maxk(nd)
                i = sumdigs ^ k
                if ndigits(i) == nd && sum(idigits(i)) == sumdigs
                    found += 1
                    if found >= n
                        @show mink(nd):maxk(nd)
                        return i
                    end
                end
            end
        end
    end
end

println(solution(30))
