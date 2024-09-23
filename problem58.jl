include("common.jl")

function solution(target = 0.1)
    odds = Iterators.countfrom(3, 2)
    odd_squares = Iterators.map(x->x^2, odds)
    bl = Iterators.map(odds, odd_squares) do n, osqr
        osqr - (n - 1)
    end
    tl = Iterators.map(odds, odd_squares) do n, osqr
        osqr - 2(n - 1)
    end
    tr = Iterators.map(odds, odd_squares) do n, osqr
        osqr - 3(n - 1)
    end

    nprimes = Iterators.accumulate(zip(bl, tl, tr), init=0) do np, diags
        np + count(isprime, diags)
    end

    return Iterators.dropwhile(zip(nprimes, odds)) do (np, o)
        tdiags = 2 * (o - 1) + 1
        np/tdiags >= target
    end |> first |> last
end

println(solution())
