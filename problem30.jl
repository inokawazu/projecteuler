sumpowdigits(n, b) = sum(x->x^b, digits(n))

issumpowequal(n, b) = n == sumpowdigits(n, b)

function solution(b)
    nmax = 1
    while 9^b * log10(nmax) > nmax
        nmax *= 10
    end

    sumpownums = Iterators.filter(n->issumpowequal(n, b), 2:nmax)
    return sum(sumpownums)
end

const INPUT = 5
println(solution(INPUT))
