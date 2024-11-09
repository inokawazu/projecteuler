function evalpoly(coefs, n)
    return mapreduce(+, coefs, 0:length(coefs)-1) do c, p
        c * n^p
    end
end

function fitmatrix(poly)
    ns = 1:length(poly)
    ps = 0:length(poly)-1

    [
     n^p for n in ns, p in ps
    ]
end

function bop(poly, fpoly)
    n = one(eltype(poly))
    while evalpoly(poly, n) == evalpoly(fpoly, n)
        n += 1
    end
    return evalpoly(fpoly, n)
end

function solution()
    T = Int

    poly = T[
        +1,
        -1, 1,
        -1, 1,
        -1, 1,
        -1, 1,
        -1, 1]

    fmat = Rational.(fitmatrix(poly))
    fout = evalpoly.(Ref(poly), 1:length(poly))

    out = zero(T)
    for diag in 1:length(poly)-1
        dmat = fmat[1:diag, 1:diag]
        dout = fout[1:diag]
        out += bop(poly, dmat\dout)
    end

    return numerator(out)
end

println(solution())
