function solution(target)
    fn = big(1)
    fnp1 = big(1)
    i = 1

    while ndigits(fn) < target
        fn, fnp1 = fnp1, fn + fnp1
        i += 1
    end

    return i
end

const TARGET = 1_000
println(solution(TARGET))
