include("common.jl")

function fibs(T=Int)
    Channel{T}() do ch
        f1 = one(T)
        f2 = one(T)
        while true
            put!(ch, f1)
            f1, f2 = f2, f1 + f2
        end
    end
end

function modfibs(T=Int, m=10^9)
    Channel{T}() do ch
        f1 = mod(one(T), m)
        f2 = mod(one(T), m)
        while true
            put!(ch, f1)
            f1, f2 = f2, mod(f1 + f2, m)
        end
    end
end

function leadfibs()
    setprecision(100, base=10) do
        phi = (big(1) + sqrt(big(5))) / big(2)
        phipowers = Iterators.accumulate(*, Iterators.repeated(phi), init=big"1.0")
        Iterators.map(phipowers) do phin
            val = floor(phin / sqrt(big(5)) + 1 / big(2))
            tenpow = max(floor(Int, log10(val)), 0)
            val, tenpow
            round(Int, round(val / big(10.0)^(tenpow - 8)))
        end
    end
end

function solution()
    n = 0
    for fs in zip(leadfibs(), modfibs())
        n += 1
        if all(ispandigital, fs)
            return n
        end
    end
end

println(solution())
