include("download_input.jl")

using .WebInput

function get_input(url = "https://projecteuler.net/resources/documents/0079_keylog.txt")
    raw_input = get_web_input(url)
    map(split(raw_input, "\n", keepempty=false)) do line
        parse.(Int, collect(line))
    end
end

function iskeymatch(guess, key)
    key_ind = 1

    for guess_elem in guess
        key_ind > length(key) && break

        if guess_elem == -1 || guess_elem == key[key_ind]
            key_ind += 1
        end
    end

    return key_ind > length(key)
end

function solution(keys = get_input())
    keys = unique(keys)
    matches_keys(guess) = all(key -> iskeymatch(guess, key), keys)

    function find_key_match!(guess, pos = 1)
        if pos > length(guess)
            return true
        end
        @assert pos >= 1 "Index must be positive!"

        for d in 0:9
            guess[pos] = d
            if matches_keys(guess) && find_key_match!(guess, pos + 1)
                return true
            end
            guess[pos] = -1
        end

        return false
    end

    for ndigs in Iterators.countfrom(4)
        guess = fill(-1, ndigs)
        if find_key_match!(guess)
            return join(guess)
        end
    end
end

println(solution())
