# https://projecteuler.net/problem=2

const LIMIT = 4_000_000

function fibsum()
    xn = 1
    xnp1 = 2
    total = xnp1

    while true
        nxp2 = xn + xnp1
        nxp2 > LIMIT && break
        xn, xnp1 = xnp1, nxp2
        if iseven(nxp2)
            total += nxp2
        end
    end
        
    return total
end


println(fibsum())
