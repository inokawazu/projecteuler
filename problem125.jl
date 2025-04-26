include("common.jl")

function revidigits(n; base = 10)
    Iterators.map(nth -> nthdigit(n, nth, base=base), ndigits(n, base=base):-1:1)
end

ispalindrome(n) = all(d1 == d2 for (d1, d2) in zip(idigits(n), revidigits(n)))

sumofsquares(l, n) = - ((-1 + l - n) * (-l + 2*l^2 + n+2*l*n + 2*n^2)) ÷ 6

function solution(n = 10^8)
    found_palis = Set{typeof(n)}()

    for ki in Iterators.countfrom(one(n))
        if sumofsquares(ki, ki + 1) >= n
            break
        end

        kf = ki + 1
        while sumofsquares(ki, kf) < n
            sumkikf = sumofsquares(ki, kf)
            if ispalindrome(sumkikf)
                push!(found_palis, sumkikf)
            end
            kf += 1
        end
    end
    
    return sum(found_palis, init=zero(n))
end

println(solution())
