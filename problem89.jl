include("download_input.jl")

using .WebInput

const URL = "https://projecteuler.net/resources/documents/0089_roman.txt"

function get_intput(url = URL)
    raw_input = get_web_input(url)
    return split(raw_input, "\n", keepempty=false)
end

# println(get_intput())

const ROMAN_TO_INT = [
                      "M" => 1_000,
                      "CM" => 900,
                      "D" => 500,
                      "CD" => 400,
                      "C" => 100,
                      "XC" => 90,
                      "L" => 50,
                      "XL" => 40,
                      "X" => 10,
                      "IX" => 9,
                      "V" => 5,
                      "IV" => 4,
                      "I" => 1,
                     ]

function parse_roman(roman)
    first_roman = roman
    # i = firstindex(roman)

    romani = 1
    out = 0

    while !isempty(roman) # checkbounds(Bool, roman, i)
        while romani <= length(ROMAN_TO_INT)
            roman_pre, roman_val = ROMAN_TO_INT[romani]

            # @info "Testing $roman_pre as start of $roman, $( startswith(roman, roman_pre) )"
            if startswith(roman, roman_pre)
                roman = chopprefix(roman, roman_pre)
                out += roman_val
                break
            end

            romani += 1
        end

        if romani > length(ROMAN_TO_INT)
            throw(ErrorException("Invalid $first_roman, at with $roman left."))
        end

    end

    return out
end

function greedy_roman(n)
    romani = 1
    out = ""

    while n > 0

        while romani <= length(ROMAN_TO_INT)
            roman_pre, roman_val = ROMAN_TO_INT[romani]

            if roman_val <= n
                n -= roman_val
                out = out * roman_pre 
                break
            end

            romani += 1
        end

        @assert romani <= length(ROMAN_TO_INT)
    end

    return out
end

function solution(input=get_intput())
    sum(input) do roman
        roman_int = parse_roman(roman)
        roman_greed = greedy_roman(roman_int)
        len_dif = length(roman) - length(roman_greed)

        @assert len_dif >= 0
        len_dif
    end
end

println(solution())

