function getnumberty(n)
    if     20 <= n < (20 + 10)
        return "twenty"
    elseif 30 <= n < (30 + 10)
        return "thirty"
    elseif 40 <= n < (40 + 10)
        return "forty"
    elseif 50 <= n < (50 + 10)
        return "fifty"
    elseif 60 <= n < (60 + 10)
        return "sixty"
    elseif 70 <= n < (70 + 10)
        return "seventy"
    elseif 80 <= n < (80 + 10)
        return "eighty"
    elseif 90 <= n < (90 + 10)
        return "ninety"
    end
    throw(ErrorException("invalid ty number n=$n."))
end

function number2text(n)
    if n == 1
        return "one"
    elseif n == 2
        return "two"
    elseif n == 3
        return "three"
    elseif n == 4
        return "four"
    elseif n == 5
        return "five"
    elseif n == 6
        return "six"
    elseif n == 7
        return "seven"
    elseif n == 8
        return "eight"
    elseif n == 9
        return "nine"
    elseif n == 10
        return "ten"
    elseif n == 11
        return "eleven"
    elseif n == 12
        return "twelve"
    elseif n == 13
        return "thirteen"
    elseif n == 14
        return "fourteen"
    elseif n == 15
        return "fifteen"
    elseif n == 16
        return "sixteen"
    elseif n == 17
        return "seventeen"
    elseif n == 18
        return "eighteen"
    elseif n == 19
        return "nineteen"
    elseif 20 <= n < 100
        onesplace = mod(n, 10)
        return getnumberty(n) * (iszero(onesplace) ? "" : "-" * number2text(onesplace))
    elseif 100 <= n < 1000
        hundredsplace, tensonesplace = divrem(n, 100)
        return number2text(hundredsplace) * " hundred" * 
               (iszero(tensonesplace) ? "" : " and " * number2text(tensonesplace))
    elseif n == 1000
        return "one thousand"
    end
    
    throw(ErrorException("n=$n is not implemented."))
end

charlength(s) = length(filter(c->c in 'a':'z', s))

function solution(limit)
    return sum(charlength∘number2text, 1:limit)
end

const LIMIT = 1000
println(solution(LIMIT))
